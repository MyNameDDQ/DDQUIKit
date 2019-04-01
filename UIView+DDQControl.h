//
//  UIView+DDQControl.h
//  DDQKitDemo
//
//  Created by 我叫咚咚枪 on 2018/12/24.
//  Copyright © 2018 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQLayoutGuide.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DDQControl)

/**
 这个大小适用于。button、field、textView、label
 */
@property (nonatomic, readonly) CGFloat defaultFontSize;//15.0
/**
 适用范围同上
 */
@property (nonatomic, strong) UIColor *defaultTextColor;//r,g,b均为51.0

/**
 初始化方法

 @param color 默认的背景颜色为透明色
 */
+ (instancetype)ddq_controlWithBackgroundColor:(nullable UIColor *)color;
+ (instancetype)ddq_control;

- (UITapGestureRecognizer *)ddq_addTapGestureRecognizer:(void(^)(UITapGestureRecognizer *tap))tp;

- (UILongPressGestureRecognizer *)ddq_addLongPressGestureRecognizer:(void(^)(UILongPressGestureRecognizer *longPress))lp;

- (void)ddq_addSubviews:(nullable NSArray<__kindof UIView *> *)subviews;
- (void)ddq_removeSubviews:(nullable NSArray<__kindof UIView *> *)subviews;
- (void)ddq_removeSubviewsWithClass:(Class)vClass NS_AVAILABLE_IOS(1_0_1);
- (void)ddq_removeAllSubviews NS_AVAILABLE_IOS(1_0_1);

@end

@interface UILabel (DDQLabelInit)

+ (UILabel *)ddq_label;
+ (UILabel *)ddq_labelWithText:(nullable NSString *)text textColor:(nullable UIColor *)color font:(nullable UIFont *)font;

/**
 初始化方法

 @param text 文字
 @param attributes 文字属性。若该属性不为空，则label显示attributeText
 @param color 文字颜色
 @param font 文字大小
 */
+ (UILabel *)ddq_labelWithText:(nullable NSString *)text attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes textColor:(nullable UIColor *)color font:(nullable UIFont *)font;

/**
 用sizeThatFits计算label大小

 @param size 给定的大小
 @return 计算后的大小，这和boundSize方法最大的差别在于，label有默认字边距。
 */
- (CGSize)ddq_labelSizeThatFits:(CGSize)size;

- (CGSize)ddq_labelBoundAttributeTextSizeWithOptions:(NSStringDrawingOptions)options size:(CGSize)size;

- (CGSize)ddq_labelBoundTextSizeWithOptions:(NSStringDrawingOptions)options size:(CGSize)size;

- (CGSize)ddq_labelBoundTextSizeWithAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes option:(NSStringDrawingOptions)options size:(CGSize)size;

@end

@interface UIButton (DDQButtonInit)

+ (UIButton *)ddq_button;

/**
 按钮的初始化。

 @param title 按钮文字
 @param tColor 文字颜色，默认defaultTextColor
 @param image 按钮图片
 @param events 点击事件的类型
 @param target 响应者
 @param selector 响应事件
 */
+ (UIButton *)ddq_buttonWithTitle:(nullable NSString *)title titleColor:(UIColor *)tColor image:(nullable UIImage *)image events:(UIControlEvents)events target:(nullable id)target selector:(nullable SEL)selector;
/**
 与上面方法区别在于响应事件的形式不同。
 */
+ (UIButton *)ddq_buttonWithTitle:(nullable NSString *)title titleColor:(UIColor *)tColor image:(nullable UIImage *)image events:(UIControlEvents)events action:(void(^)(UIButton *button))action;

+ (UIButton *)ddq_buttonWithTitle:(nullable NSString *)title titleColor:(UIColor *)tColor attributeString:(nullable NSAttributedString *)attribute image:(nullable UIImage *)image backgroundImage:(nullable UIImage *)bImage events:(UIControlEvents)events target:(nullable id)target selector:(nullable SEL)selector;
+ (UIButton *)ddq_buttonWithTitle:(nullable NSString *)title titleColor:(UIColor *)tColor attributeString:(nullable NSAttributedString *)attribute image:(nullable UIImage *)image backgroundImage:(nullable UIImage *)bImage events:(UIControlEvents)events action:(void(^)(UIButton *button))action;

@end

@interface UITextField (DDQFieldInit)

+ (UITextField *)ddq_textField;

+ (UITextField *)ddq_textFieldWithTextColor:(nullable UIColor *)tColor font:(nullable UIFont *)font;

/**
 初始化方法

 @param tColor 文字颜色。默认
 @param font 文字大小。默认
 @param placeholder 占位字符传
 @param pAttributes 占位字符串属性
 */
+ (UITextField *)ddq_textFieldWithTextColor:(nullable UIColor *)tColor font:(nullable UIFont *)font placeholder:(nullable NSString *)placeholder placeholderAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)pAttributes;

@end

@interface UIImageView (DDQImageViewInit)

+ (UIImageView *)ddq_imageView;

+ (UIImageView *)ddq_imageViewWithImage:(nullable UIImage *)image;

/**
 初始化imageView

 @param image 图片
 @param mode 默认UIViewContentModeScaleAspectFill
 */
+ (UIImageView *)ddq_imageViewWithImage:(nullable UIImage *)image contentMode:(UIViewContentMode)mode;

@end

@interface UITableView (DDQTableViewInit)

+ (UITableView *)ddq_tableViewWithDeletegate:(nullable id<UITableViewDelegate>)delegate dataSource:(nullable id<UITableViewDataSource>)source;

+ (UITableView *)ddq_tableViewWithStyle:(UITableViewStyle)style deletegate:(nullable id<UITableViewDelegate>)delegate dataSource:(nullable id<UITableViewDataSource>)source;

@property (nonatomic, readonly) NSString *defaultReuseIdentifier;

@end

@interface UICollectionView (DDQCollectionViewInit)

+ (UICollectionView *)ddq_collectionViewWithDeletegate:(nullable id<UICollectionViewDelegate>)delegate dataSource:(nullable id<UICollectionViewDataSource>)source;

+ (UICollectionView *)ddq_collectionViewWithDeletegate:(nullable id<UICollectionViewDelegate>)delegate dataSource:(nullable id<UICollectionViewDataSource>)source flowLayout:(nullable __kindof UICollectionViewLayout *)layout;

@property (nonatomic, readonly) NSString *defaultReuseIdentifier;

@end

@interface UITextView (DDQTextViewInit)

+ (UITextView *)ddq_textView;

+ (UITextView *)ddq_textViewWithDelegate:(nullable id<UITextViewDelegate>)delegate;

+ (UITextView *)ddq_textViewWithDelegate:(nullable id<UITextViewDelegate>)delegate textContainer:(nullable NSTextContainer *)container;

/**
 TextView编辑光标起始位置
 */
@property (nonatomic, readonly) CGRect beginningRect;

@end

NS_ASSUME_NONNULL_END
