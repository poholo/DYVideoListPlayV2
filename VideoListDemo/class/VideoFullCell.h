//
// Created by majiancheng on 2018/6/7.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoDto;
@class PlayerBaseView;


@interface VideoFullCell : UITableViewCell

- (void)loadData:(VideoDto *)videoDto;

- (void)updatePlayerView:(PlayerBaseView *)playerView;

+ (CGFloat)height;

+ (NSString *)identifier;

@end