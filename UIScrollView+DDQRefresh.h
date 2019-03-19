//
//  UIScrollView+DDQRefresh.h
//  DDQKitDemo
//
//  Created by 我叫咚咚枪 on 2018/12/24.
//  Copyright © 2018 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQControl.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQRefreshHeaderStyle) {
    
    DDQRefreshHeaderStyleNone,
    DDQRefreshHeaderStyleNormal,
    DDQRefreshHeaderStyleGif,
    DDQRefreshHeaderStyleState,
    
};

typedef NS_ENUM(NSUInteger, DDQRefreshFooterStyle) {
    
    DDQRefreshFooterStyleNone,
    DDQRefreshFooterStyleAuto,
    DDQRefreshFooterStyleBack,
    DDQRefreshFooterStyleAutoNormal,
    DDQRefreshFooterStyleBackNormal,
    DDQRefreshFooterStyleAutoGif,
    DDQRefreshFooterStyleBackGif,
    DDQRefreshFooterStyleAutoState,
    DDQRefreshFooterStyleBackState,
    
};

@interface UIScrollView (DDQRefresh)

/**
 初始化一个带有header和footer的scrollView及其子类

 @param hs 对应MJ的不同header。None则不设置
 @param hAction header刷新回调事件
 @param fs 对应MJ不同的footer。None则不设置
 @param fAction footer刷新回调事件
 @param delegate 代理
 @param dataSource 数据源
 */
+ (instancetype)ddq_refreshHeaderStyle:(DDQRefreshHeaderStyle)hs headerAction:(void(^)(void))hAction footerStyle:(DDQRefreshFooterStyle)fs footerAction:(void(^)(void))fAction delegate:(nullable id)delegate dataSource:(nullable id)dataSource;

- (void)ddq_endRefreshIsNormalData:(BOOL)is;

@end

NS_ASSUME_NONNULL_END
