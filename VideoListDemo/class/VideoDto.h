//
// Created by majiancheng on 2018/6/5.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//


#import <CoreGraphics/CoreGraphics.h>

#import <Foundation/Foundation.h>

@interface VideoDto : NSObject

@property(nonatomic, strong) NSString *entityId;
@property(nonatomic, strong) NSString *imageUrl;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@end