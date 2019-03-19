//
//  UIView+DDQControl.m
//  DDQKitDemo
//
//  Created by 我叫咚咚枪 on 2018/12/24.
//  Copyright © 2018 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQControl.h"

#import <YYKit/YYKit.h>

@implementation UIView (DDQControl)

static const char * DefaultTextColorKey = "defaultTextColor";

- (CGFloat)defaultFontSize {
    
    return 15.0;
    
}

- (void)setDefaultTextColor:(UIColor *)defaultTextColor {
    
    objc_setAssociatedObject(self, DefaultTextColorKey, defaultTextColor, OBJC_ASSOCIATION_RETAIN);
    
}

- (UIColor *)defaultTextColor {
    
    id object = objc_getAssociatedObject(self, DefaultTextColorKey);
    if (!object) {
        
        return DDQColorWithRGB(51.0, 51.0, 51.0);
        
    }
    return object;
    
}

+ (instancetype)ddq_control {
    
    return [self.class ddq_controlWithBackgroundColor:nil];
    
}

+ (instancetype)ddq_controlWithBackgroundColor:(UIColor *)color {
    
    id control = ([self respondsToSelector:@selector(initWithFrame:)]) ? [[self alloc] initWithFrame:CGRectZero] : [[self alloc] init];
    if ([control respondsToSelector:@selector(setBackgroundColor:)]) {
        
        [control setBackgroundColor:color ? color : [UIColor clearColor]];
        
    }
    return control;
    
}

- (UITapGestureRecognizer *)ddq_addTapGestureRecognizer:(void (^)(UITapGestureRecognizer * _Nonnull))tp {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        
        if (tp) {
            
            tp(sender);
            
        }
    }];
    [self addGestureRecognizer:tap];
    return tap;
    
}

- (UILongPressGestureRecognizer *)ddq_addLongPressGestureRecognizer:(void (^)(UILongPressGestureRecognizer * _Nonnull))lp {
    
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        
        if (lp) {
            
            lp(sender);
            
        }
    }];
    [self addGestureRecognizer:longP];
    return longP;
    
}

- (void)ddq_addSubviews:(NSArray<__kindof UIView *> *)subviews {
    
    if (subviews.count == 0 || !subviews) {
        
        return;
        
    }
    
    for (id view in subviews) {
        
        if (![self.subviews containsObject:view]) {
            
            [self addSubview:view];
            
        }
    }
}

- (void)ddq_removeSubviews:(NSArray<__kindof UIView *> *)subviews {
    
    if (subviews.count == 0 || !subviews) {
        
        return;
        
    }
    
    for (id view in subviews) {
        
        if ([self.subviews containsObject:view]) {
            
            [view removeFromSuperview];
            
        }
    }
}

@end


@implementation UILabel (DDQLabelInit)

+ (UILabel *)ddq_label {
    
    UILabel *label = [self.class ddq_control];
    label.numberOfLines = 0;
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:label.defaultFontSize];
    label.textColor = label.defaultTextColor;
    return label;
    
}

+ (UILabel *)ddq_labelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font {
    
    return [self.class ddq_labelWithText:text attributes:nil textColor:color font:font];
    
}

+ (UILabel *)ddq_labelWithText:(NSString *)text attributes:(NSDictionary<NSAttributedStringKey,id> *)attributes textColor:(UIColor *)color font:(UIFont *)font {
    
    UILabel *label = [UILabel ddq_label];
    if ((attributes && attributes.count > 0) && text) {
        
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        label.attributedText = attributeString;
        
    }
    
    if (font) label.font = font;
    if (color) label.textColor = color;
    return label;
    
}

- (CGSize)ddq_labelSizeThatFits:(CGSize)size {
    
    CGSize fitSize = [self sizeThatFits:size];
    return CGSizeMake(MIN(size.width, fitSize.width), MIN(size.height, fitSize.height));
    
}

- (CGSize)ddq_labelBoundAttributeTextSizeWithOptions:(NSStringDrawingOptions)options size:(CGSize)size {
    
    CGSize boundSize = [self.attributedText boundingRectWithSize:size options:options context:nil].size;
    return CGSizeMake(ceil(boundSize.width), ceil(boundSize.height));
    
}

- (CGSize)ddq_labelBoundTextSizeWithOptions:(NSStringDrawingOptions)options size:(CGSize)size {
    
    return [self ddq_labelBoundTextSizeWithAttributes:nil option:options size:size];
    
}

- (CGSize)ddq_labelBoundTextSizeWithAttributes:(NSDictionary<NSAttributedStringKey,id> *)attributes option:(NSStringDrawingOptions)options size:(CGSize)size {
    
    CGSize boundSize = CGSizeZero;
    if (attributes && attributes.count > 0) {
        
        boundSize = [self.text boundingRectWithSize:size options:options attributes:attributes context:nil].size;
        
    } else {
        
        boundSize = [self.text boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:self.font} context:nil].size;
        
    }
    return CGSizeMake(ceil(boundSize.width), ceil(boundSize.height));
    
}

@end

@implementation UIButton (DDQButtonInit)

+ (UIButton *)ddq_button {
    
    UIButton *button = [self.class ddq_control];
    button.titleLabel.font = [UIFont systemFontOfSize:button.defaultFontSize];
    [button setTitleColor:button.defaultTextColor forState:UIControlStateNormal];
    return button;
    
}

+ (UIButton *)ddq_buttonWithTitle:(NSString *)title titleColor:(UIColor *)tColor image:(UIImage *)image events:(UIControlEvents)events action:(void (^)(UIButton * _Nonnull))action{
    
    return [self.class ddq_buttonWithTitle:title titleColor:tColor attributeString:nil image:image backgroundImage:nil events:events action:action];
    
}

+ (UIButton *)ddq_buttonWithTitle:(NSString *)title titleColor:(UIColor *)tColor attributeString:(NSAttributedString *)attribute image:(UIImage *)image backgroundImage:(UIImage *)bImage events:(UIControlEvents)events action:(void (^)(UIButton * _Nonnull))action {
    
    UIButton *button = [self.class ddq_button];
    [button ddq_handleButtonWithImage:image backgroundImage:nil textColor:tColor attributeString:nil title:title];
    if (action) {
        
        [button addBlockForControlEvents:events block:^(id  _Nonnull sender) {
            
            action(sender);
            
        }];
    }
    return button;

}

+ (UIButton *)ddq_buttonWithTitle:(NSString *)title titleColor:(UIColor *)tColor image:(UIImage *)image events:(UIControlEvents)events target:(id)target selector:(SEL)selector {
    
    return [self.class ddq_buttonWithTitle:title titleColor:tColor attributeString:nil image:image backgroundImage:nil events:events target:target selector:selector];
    
}

+ (UIButton *)ddq_buttonWithTitle:(NSString *)title titleColor:(UIColor *)tColor attributeString:(NSAttributedString *)attribute image:(UIImage *)image backgroundImage:(UIImage *)bImage events:(UIControlEvents)events target:(id)target selector:(SEL)selector {
    
    UIButton *button = [self.class ddq_button];
    [button ddq_handleButtonWithImage:image backgroundImage:bImage textColor:tColor attributeString:attribute title:title];
    if (target && selector) {
        
        [button addTarget:target action:selector forControlEvents:events];
        
    }
    return button;
    
}

- (void)ddq_handleButtonWithImage:(UIImage *)image backgroundImage:(UIImage *)bimage textColor:(UIColor *)tcolor attributeString:(NSAttributedString *)attribute title:(NSString *)title {
    
    if (title) [self setTitle:title forState:UIControlStateNormal];
    if (tcolor) [self setTitleColor:tcolor forState:UIControlStateNormal];
    if (image) [self setImage:image forState:UIControlStateNormal];
    if (attribute) [self setAttributedTitle:attribute forState:UIControlStateNormal];
    if (bimage) [self setBackgroundImage:bimage forState:UIControlStateNormal];

}

@end


@implementation UITextField (DDQFieldInit)

+ (UITextField *)ddq_textField {
    
    UITextField *field = [self.class ddq_control];
    field.textColor = field.defaultTextColor;
    field.font = [UIFont systemFontOfSize:field.defaultFontSize];
    return field;

}

+ (UITextField *)ddq_textFieldWithTextColor:(UIColor *)tColor font:(UIFont *)font {
    
    return [self.class ddq_textFieldWithTextColor:tColor font:font placeholder:nil placeholderAttributes:nil];
    
}

+ (UITextField *)ddq_textFieldWithTextColor:(UIColor *)tColor font:(UIFont *)font placeholder:(NSString *)placeholder placeholderAttributes:(NSDictionary<NSAttributedStringKey,id> *)pAttributes {
    
    UITextField *field = [UITextField ddq_textField];
    if (tColor) field.textColor = tColor;
    if (font) field.font = font;
    if (placeholder) field.placeholder = placeholder;
    if (field.placeholder.length > 0 && pAttributes) {
        
        NSMutableDictionary *attributes = pAttributes.mutableCopy;
        if (![attributes containsObjectForKey:NSFontAttributeName]) {
            
            [attributes setObject:[UIFont systemFontOfSize:field.defaultFontSize] forKey:NSFontAttributeName];
            
        }
        
        if (![attributes containsObjectForKey:NSForegroundColorAttributeName]) {
            
            [attributes setObject:field.defaultTextColor forKey:NSForegroundColorAttributeName];
            
        }
        NSAttributedString *placeholderAttributes = [[NSAttributedString alloc] initWithString:field.placeholder attributes:attributes.copy];
        field.attributedPlaceholder = placeholderAttributes;
        
    }
    return field;
    
}

@end

@implementation UIImageView (DDQImageViewInit)

+ (UIImageView *)ddq_imageView {
    
    UIImageView *imageView = [UIImageView ddq_control];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    return imageView;
    
}

+ (UIImageView *)ddq_imageViewWithImage:(UIImage *)image {
    
    UIImageView *imageView = [self.class ddq_imageView];
    if (image) imageView.image = image;
    return imageView;
    
}

+ (UIImageView *)ddq_imageViewWithImage:(UIImage *)image contentMode:(UIViewContentMode)mode {
    
    UIImageView *imageView = [self.class ddq_imageViewWithImage:image];
    imageView.contentMode = mode;
    return imageView;
    
}

@end

@implementation UITableView (DDQTableViewInit)

+ (UITableView *)ddq_tableViewWithDeletegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)source {
    
    return [self.class ddq_tableViewWithStyle:UITableViewStyleGrouped deletegate:delegate dataSource:source];
    
}

+ (UITableView *)ddq_tableViewWithStyle:(UITableViewStyle)style deletegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)source {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableView.defaultReuseIdentifier];
    tableView.estimatedRowHeight = 0.0;
    tableView.estimatedSectionFooterHeight = 0.0;
    tableView.estimatedSectionHeaderHeight = 0.0;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (delegate) tableView.delegate = delegate;
    if (source) tableView.dataSource = source;
    return tableView;
    
}

- (NSString *)defaultReuseIdentifier {
    
    return @"tableView.defaultReuseIdentifier";
    
}

@end

@implementation UICollectionView (DDQCollectionViewInit)

+ (UICollectionView *)ddq_collectionViewWithDeletegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)source {
    
    return [self.class ddq_collectionViewWithDeletegate:delegate dataSource:source flowLayout:nil];
    
}

+ (UICollectionView *)ddq_collectionViewWithDeletegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)source flowLayout:(__kindof UICollectionViewLayout *)layout {
    
    if (!layout) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        layout = flowLayout;
        
    }
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    if (delegate) collectionView.delegate = delegate;
    if (source) collectionView.dataSource = source;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionView.defaultReuseIdentifier];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    
    return collectionView;

}

- (NSString *)defaultReuseIdentifier {
    
    return @"collectionView.defaultReuseIdentifier";
    
}

@end

@implementation UITextView (DDQTextViewInit)

+ (UITextView *)ddq_textView {
    
    return [self.class ddq_textViewWithDelegate:nil textContainer:nil];
    
}

+ (UITextView *)ddq_textViewWithDelegate:(id<UITextViewDelegate>)delegate {
    
    return [self.class ddq_textViewWithDelegate:delegate textContainer:nil];
    
}

+ (UITextView *)ddq_textViewWithDelegate:(id<UITextViewDelegate>)delegate textContainer:(NSTextContainer *)container {
    
    UITextView *textView = container ? [[UITextView alloc] initWithFrame:CGRectZero textContainer:container] : [UITextView ddq_control];
    if (delegate) textView.delegate = delegate;
    textView.font = [UIFont systemFontOfSize:textView.defaultFontSize];
    textView.textColor = textView.defaultTextColor;
    
    return textView;
    
}

- (CGRect)beginningRect {
    
    return [self caretRectForPosition:self.beginningOfDocument];
    
}

@end


