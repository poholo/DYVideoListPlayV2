//
// Created by majiancheng on 2018/6/7.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "VideoFullCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "VideoDto.h"
#import "PlayerBaseView.h"

@interface VideoFullCell ()

@property(nonatomic, strong) UIImageView *coverImageView;

@end

@implementation VideoFullCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    [self.contentView addSubview:self.coverImageView];
}

- (void)loadData:(VideoDto *)videoDto {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:videoDto.imageUrl] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)updatePlayerView:(PlayerBaseView *)playerView {
    [self.coverImageView addSubview:playerView];
}

#pragma mark - getter

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, [self class].height)];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

+ (CGFloat)height {
    return UIScreen.mainScreen.bounds.size.height;
}


+ (NSString *)identifier {
    return NSStringFromClass(self.class);
}


@end