//
//  DDQCell.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQControl.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQCellSeparatorStyle) {
    
    DDQCellSeparatorStyleNone,           //不显示分割线
    DDQCellSeparatorStyleTop,            //显示上分割线
    DDQCellSeparatorStyleBottom,         //显示下分割线
    
};

struct DDQSeparatorMargin {
    
    CGFloat leftMargin;
    CGFloat rightMargin;
    
};
typedef struct DDQSeparatorMargin DDQSeparatorMargin;

UIKIT_EXTERN const DDQSeparatorMargin DDQSeparatorMarginZero;

UIKIT_STATIC_INLINE DDQSeparatorMargin DDQSeparatorMarginMaker(CGFloat l, CGFloat r);
UIKIT_STATIC_INLINE NSString *DDQStringFromSeparatorMargin(DDQSeparatorMargin margin);

/**
 基类cell
 */
@interface DDQCell : UITableViewCell

@property (nonatomic, assign) DDQCellSeparatorStyle cell_separatorStyle;//defalut BQCellSeparatorStyleNone
@property (nonatomic, assign) DDQSeparatorMargin cell_separatorMargin;//default 15.0 * 当前屏幕宽度和iPhone6宽度的比例

@property (nonatomic, assign) CGFloat cell_separatorHeight;//default 0.5
@property (nonatomic, strong) UIColor *cell_separatorColor;//default r:153.0, g:153.0, b:153.0

/**
 当前cell的宽度。默认是当前屏幕宽度
 */
@property (nonatomic, assign) CGFloat cell_preferredMaxWidth;

/**
 标准屏幕比例，默认iPhone6
 */
@property (nonatomic, readonly) DDQScreenScale cell_scale;

/**
 当前屏宽和iPhone6的比
 */
@property (nonatomic, readonly) CGFloat cell_widthScale;

/**
 cell是不是已经执行过layoutSubviews
 */
@property (nonatomic, readonly) BOOL cell_layoutSubviews;

/**
 cell是不是已经执行过cell_foundationConfigSubviews
 */
@property (nonatomic, readonly) BOOL cell_configSubviews;

/**
 配置子视图的方法，子类用以实现子视图的添加
 */
- (void)cell_foundationConfigSubviews;

/**
 cell调用layoutSubviews时响应此方法，用来更新cell.contentView上视图的大小
 */
- (void)cell_foundationCellFrameDidUpdated;

/**
 在视图setFrame:时是否调用cell_foundationCellFrameDidUpdated更新子视图大小
 
 @return default NO
 */
+ (BOOL)cell_callDidUpdateWhenSetFrameIfNeeds;

/**
 是否需要强制执行修正cell的目标宽度即：cell_preferredMaxWidth
 
 @return default YES
 */
+ (BOOL)cell_adjustsForceFitMaxWidth;

@end

UIKIT_STATIC_INLINE DDQSeparatorMargin DDQSeparatorMarginMaker(CGFloat l, CGFloat r) {
    
    DDQSeparatorMargin margin; margin.leftMargin = l; margin.rightMargin = r; return margin;
    
}

UIKIT_STATIC_INLINE NSString *DDQStringFromSeparatorMargin(DDQSeparatorMargin margin) {
    
    return [NSString stringWithFormat:@"<leftMargin = %f; rightMargin = %f>", margin.leftMargin, margin.rightMargin];

}

NS_ASSUME_NONNULL_END
