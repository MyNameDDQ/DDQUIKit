//
//  DDQButton.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/31.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQButtonStyle) {
    
    DDQButtonStyleImageTop,     //上图下字。default value
    DDQButtonStyleImageLeft,    //左图右字
    DDQButtonStyleImageBottom,  //上字下图
    DDQButtonStyleImageRight,   //左字右图
    
};

NS_AVAILABLE_IOS(1_0_1)
@interface DDQButton : DDQView

- (instancetype)initWithButtonStyle:(DDQButtonStyle)style NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)setImage:(nullable UIImage *)image;
- (void)setBackgroundImage:(nullable UIImage *)bImage;
- (void)setTitle:(nullable NSString *)title;
- (void)setAttributeTitle:(nullable NSAttributedString *)attribute;
- (void)setTitleColor:(nullable UIColor *)color;
- (void)setTitleFont:(nullable UIFont *)font;

/**
 布局边界
 */
@property (nonatomic, assign) UIEdgeInsets layoutInsets;//default UIEdgeInsetsZero

/**
 文字和图片的间距
 */
@property (nonatomic, assign) CGFloat controlSpace;//default 5.0

/**
 设置图片最大大小
 */
@property (nonatomic, assign) CGSize imageSize;//设置图片的大小

@end

NS_ASSUME_NONNULL_END
