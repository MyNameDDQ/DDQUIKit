//
//  DDQView.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQLayoutGuide.h"

NS_ASSUME_NONNULL_BEGIN

/**
 视图基类
 */
@interface DDQView : UIView

/**
 默认的屏幕大小比
 */
@property (nonatomic, readonly) DDQScreenScale view_scale;
@property (nonatomic, readonly) CGFloat view_widthScale;

/**
 有没有调取过layoutSubviews
 */
@property (nonatomic, readonly) BOOL view_layoutSubviews;

/**
 有没有掉取过view_foundationConfigSubviews
 */
@property (nonatomic, readonly) BOOL view_configSubviews;

/**
 配置子视图的方法，子类用以实现子视图的添加
 */
- (void)view_foundationConfigSubviews;

/**
 视图调用layoutSubviews时响应此方法，用来更新View上视图的大小
 */
- (void)view_foundationViewFrameDidUpdate;

/**
 在视图setFrame:时是否调用view_foundationViewFrameDidUpdate更新子视图大小
 
 @return default NO
 */
+ (BOOL)view_callDidUpdateWhenSetFrameIfNeeds;

@end

NS_ASSUME_NONNULL_END
