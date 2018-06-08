//
//  HotFlowViewController.m
//  Bull
//
//  Created by 孙元洋 on 2018/6/7.
//  Copyright © 2018年 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "HotFlowViewController.h"

#import <ReactiveCocoa.h>

#import "HotFlowDataVM.h"
#import "VideoFullCell.h"
#import "PlayerKit.h"
#import "PlayerView.h"
#import "VideoDto.h"

@interface HotFlowViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) HotFlowDataVM *dataVM;

@property(nonatomic, strong) PlayerKit *playerKit;
@property(nonatomic, strong) PlayerView *playerView;


@end

@implementation HotFlowViewController

- (void)dealloc {
    [self.playerKit pause];
    [self.playerKit destoryPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[VideoFullCell class] forCellReuseIdentifier:[VideoFullCell identifier]];
    self.tableView.pagingEnabled = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;

    [self configPlayer];
    [self addEvent];

    [self refresh];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self pause];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self play];
}

- (void)configPlayer {
    self.playerView = [[PlayerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.playerView.playerStyle = PlayerStyleSizeRegularAuto;
    [self.view addSubview:self.playerView];

    self.playerKit = ({
        PlayerKit *kit = [[PlayerKit alloc] initWithPlayerView:self.playerView];
        kit.playerCoreType = PlayerCoreAVPlayer;
        kit.actionAtItemEnd = PlayerActionAtItemEndCircle;
        kit;
    });
}

- (void)addEvent {
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self pause];
    }];

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self play];
    }];
}

- (void)pause {
    [self.playerKit pause];
}

- (void)play {
    if (self.navigationController.topViewController == self) {
        [self.playerKit play];
    }
}

#pragma mark -


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoFullCell *cell = [tableView dequeueReusableCellWithIdentifier:[VideoFullCell identifier] forIndexPath:indexPath];
    [cell loadData:self.dataVM.dataList[indexPath.row]];

    [self.playerKit playUrls:@[((VideoDto *) self.dataVM.dataList[indexPath.row]).url]];
    [cell updatePlayerView:self.playerView];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [VideoFullCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)refresh {
    if (self.dataVM.isRefresh) return;

    [self.dataVM refresh];
    [self loadData];
}

- (void)loadData {
    RACSignal *signal = [self.dataVM requestVideoList];
    @weakify(self);
    [signal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        self.dataVM.isRefresh = NO;

    }               error:^(NSError *error) {
        @strongify(self);
        [self.tableView reloadData];
        self.dataVM.isRefresh = NO;
    }];

}

- (HotFlowDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [HotFlowDataVM new];
    }
    return _dataVM;
}
@end
