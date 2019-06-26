//
//  DDQTextLayoutLabel.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQTextLayoutLabelStyle) {
    
    DDQTextLayoutLabelStyleNormal,               //默认的布局方式，在有限的宽度下竟可能的显示更多的字
    DDQTextLayoutLabelStyleLastLineNotOneChar,   //最后一行永远不会是一个字

};

/**
 文本布局视图。避免了系统文本布局断行时，导致的留白过多的问题。
 但是这个类暂时不能支持\n。
 */
@interface DDQTextLayoutLabel : DDQView

/**
 初始化流程

 @param style 文字的显示方式
 */
- (instancetype)initLayoutLabelWithStyle:(DDQTextLayoutLabelStyle)style NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, copy, nullable) NSAttributedString *attributedText;

@property (nonatomic, strong) UIColor *textColor;//default rgb 51.0
@property (nonatomic, strong) UIFont *font;//default size:17.0
@property (nonatomic, assign) NSTextAlignment textAlignment;//default NSTextAlignmentLeft
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;//defalut NSLineBreakByWordWrapping
@property (nonatomic, assign) NSInteger numberOfLines;//default 2

@property (nonatomic, assign) CGFloat lineHeight;//NSParagraphStyleAttributeName 将影响此属性
@property (nonatomic, assign) CGFloat kern;//NSKernAttributeName 将影响此属性
@property (nonatomic, readonly) NSDictionary *defaultAttributes;//默认的字符串属性

@end

NS_ASSUME_NONNULL_END
