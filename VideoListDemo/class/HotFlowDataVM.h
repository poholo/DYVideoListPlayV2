//
// Created by majiancheng on 2018/6/7.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//



#import <Foundation/Foundation.h>

@class RACSignal;

@interface HotFlowDataVM : NSObject

@property(nonatomic, assign) BOOL isRefresh;

@property(nonatomic, strong) NSMutableArray *dataList;

- (void)refresh;

- (RACSignal *)requestVideoList;


@end