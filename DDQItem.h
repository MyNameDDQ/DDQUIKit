//
//  DDQItem.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQLayoutGuide.h"

NS_ASSUME_NONNULL_BEGIN

/**
 基类collectionViewCell
 */
@interface DDQItem : UICollectionViewCell

@property (nonatomic, readonly) DDQScreenScale item_scale;
@property (nonatomic, readonly) CGFloat item_widthScale;

/**
 有没有调取过layoutSubviews
 */
@property (nonatomic, readonly) BOOL item_layoutSubviews;

/**
 配置子视图的方法，子类用以实现子视图的添加
 */
- (void)item_foundationConfigSubviews;

/**
 视图调用layoutSubviews时响应此方法，用来更新item.contentView上视图的大小
 */
- (void)item_foundationItemFrameDidUpdate;

/**
 在视图setFrame:时是否调用item_foundationItemFrameDidUpdate更新子视图大小
 
 @return default NO
 */
+ (BOOL)item_callDidUpdateWhenSetFrameIfNeeds;

@end

NS_ASSUME_NONNULL_END
