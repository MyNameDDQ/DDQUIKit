//
//  DDQTextLayoutLabel.m
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQTextLayoutLabel.h"

#import <YYKit/YYKit.h>
#import <CoreText/CoreText.h>
#import "UIView+DDQControl.h"

@interface DDQTextLayoutLabel ()

@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, assign) CGFloat charSpacing;
@property (nonatomic, strong) NSMutableDictionary *displayAttributes;
@property (nonatomic, assign) DDQTextLayoutLabelStyle style;

@end

@implementation DDQTextLayoutLabel

- (instancetype)initLayoutLabelWithStyle:(DDQTextLayoutLabelStyle)style {
    
    self = [super initWithFrame:CGRectZero];
    
    if (!self) {
        return nil;
    }
    
    self.style = style;
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (!self) {
        return nil;
    }
    
    self.style = DDQTextLayoutLabelStyleNormal;
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initLayoutLabelWithStyle:DDQTextLayoutLabelStyleNormal];
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize boundSize = CGSizeZero;
    if (self.text.length == 0)
        return boundSize;
    
    @try {
        
        [self.labels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj removeFromSuperview];
            
        }];
        [self.labels removeAllObjects];
        
        CGFloat totalHeight = 0.0;
        NSArray<NSString *> *texts = [self label_handlerDisplayContentWithText:self.text maxWidth:size.width];
        if (self.numberOfLines == 0 || texts.count <= self.numberOfLines) {//无限行数或者小于等于最大行数
            
            for (NSInteger index = 0; index < texts.count; index++) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.font = self.font;
                label.textColor = self.textColor;
                label.textAlignment = NSTextAlignmentLeft;
                label.lineBreakMode = (index == texts.count - 1) ? NSLineBreakByTruncatingTail : NSLineBreakByClipping;
                label.tag = index;
                [self addSubview:label];
                [self.labels addObject:label];
                
                NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:texts[index] attributes:self.displayAttributes];
                label.attributedText = attrText;
                
            }
        } else {
            
            NSArray *remaindStrings = [texts subarrayWithRange:NSMakeRange(self.numberOfLines, texts.count - self.numberOfLines)];
            for (NSInteger index = 0; index < self.numberOfLines; index++) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.font = self.font;
                label.textColor = self.textColor;
                label.textAlignment = NSTextAlignmentLeft;
                label.lineBreakMode = (index == self.numberOfLines - 1) ? NSLineBreakByTruncatingTail : NSLineBreakByClipping;
                label.tag = index;
                [self addSubview:label];
                [self.labels addObject:label];
                
                NSString *text = @"";
                if (index == self.numberOfLines - 1) {
                    
                    //这是为了实现自动...功能
                    text = [texts[index] stringByAppendingString:[remaindStrings componentsJoinedByString:@""]];
                    
                } else {
                    
                    text = texts[index];
                    
                }
                label.attributedText = [[NSAttributedString alloc] initWithString:text attributes:self.displayAttributes];
                
            }
        }
        totalHeight = (self.labels.count * self.font.lineHeight) + ((self.labels.count - 1) * self.lineHeight);
        boundSize.width = size.width;
        boundSize.height = totalHeight;
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@", exception);
        
    } @finally {
        
        [self setNeedsLayout];
        return boundSize;
        
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __block UIView *targetView = nil;
    if (self.labels.count == 1) {//单行文字居中显示
        
        UILabel *label = self.labels.firstObject;
        CGSize size = [label sizeThatFits:CGSizeMake(self.ddqWidth, label.font.lineHeight + 2.0)];
        label.frame = CGRectMake(0.0, self.ddqBoundsMidY - size.height * 0.5, MIN(size.width, self.ddqWidth), size.height);
        
    } else {
        
        [self.labels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGSize size = [obj sizeThatFits:CGSizeMake(self.ddqWidth, obj.font.lineHeight + 2.0)];
            obj.frame = CGRectMake(0.0, targetView.ddqFrameMaxY + (idx == 0 ? 0.0 : self.lineHeight), MIN(size.width, self.ddqWidth), size.height);
            targetView = obj;
            
        }];
    }
}

- (void)view_foundationConfigSubviews {
    
    [super view_foundationConfigSubviews];
    
    self.labels = [NSMutableArray array];
    
    self.numberOfLines = 2;
    self.textAlignment = NSTextAlignmentLeft;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.font = DDQFontWithSize(17.0);
    self.textColor = DDQColorWithRGB(51.0, 51.0, 51.0);
    self.lineHeight = 5.0;
    self.charSpacing = 1.0;
    
    self.displayAttributes = [NSMutableDictionary dictionary];
    [self.displayAttributes setObject:self.font.copy forKey:NSFontAttributeName];
    [self.displayAttributes setObject:self.textColor.copy forKey:NSForegroundColorAttributeName];
    [self.displayAttributes setObject:@(self.charSpacing) forKey:NSKernAttributeName];
    
}

- (BOOL)label_checkIsNumber:(NSString *)str {
    
    if ([self label_isInt:str] || [self label_isFloat:str] || [self label_isDouble:str]) {
        
        return YES;
        
    }
    return NO;
    
}

/**
 判断是不是纯整数
 
 @param str 字符串
 */
- (BOOL)label_isInt:(NSString *)str {
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    int i = 0;
    return [scanner scanInt:&i] && [scanner isAtEnd];
    
}

/**
 判断是不是浮点数
 
 @param str 字符串
 */
- (BOOL)label_isFloat:(NSString *)str {
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    float f = 0;
    return [scanner scanFloat:&f] && [scanner isAtEnd];
    
}

/**
 判断是不是双精度浮点数
 
 @param str 字符串
 */
- (BOOL)label_isDouble:(NSString *)str {
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    double d = 0;
    return [scanner scanDouble:&d] && [scanner isAtEnd];
    
}

- (NSDictionary *)defaultAttributes {
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    style.lineSpacing = self.lineHeight;
    
    UIFont *titleFont = DDQFontWithSize(17.0);
    
    NSDictionary *attributes = @{NSFontAttributeName:titleFont, NSParagraphStyleAttributeName:style.copy, NSForegroundColorAttributeName:DDQColorWithRGB(51.0, 51.0, 51.0), NSKernAttributeName:@1.0};
    return attributes;
    
}

- (void)setFont:(UIFont *)font {
    
    _font = font;
    
    [self.displayAttributes setObject:font forKey:NSFontAttributeName];
    
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    _attributedText = attributedText;
    
    NSDictionary *attributes = attributedText.attributes;
    if (attributes[NSParagraphStyleAttributeName]) {
        
        NSParagraphStyle *style = attributes[NSParagraphStyleAttributeName];
        self.lineHeight = style.lineSpacing;
        
    }
    
    if (attributes[NSFontAttributeName]) {
        
        self.font = attributes[NSFontAttributeName];
        [self.displayAttributes setObject:self.font.copy forKey:NSFontAttributeName];
        
    }
    
    if (attributes[NSForegroundColorAttributeName]) {
        
        self.textColor = attributes[NSForegroundColorAttributeName];
        [self.displayAttributes setObject:self.textColor.copy forKey:NSForegroundColorAttributeName];
        
    }
    
    if (attributes[NSKernAttributeName]) {
        
        self.charSpacing = [attributes[NSKernAttributeName] floatValue];
        [self.displayAttributes setObject:@(self.charSpacing) forKey:NSKernAttributeName];
        
    }
    
    self.text = _attributedText.string;
    
}

/**
 返回需要显示多行，每行显示什么内容
 
 @param text 需要显示的文本
 @param width 显示的最大宽度
 @return 数组。数组count即为行数，各元素即为每行文本内容。
 */
- (NSArray<NSString *> *)label_handlerDisplayContentWithText:(NSString *)text maxWidth:(CGFloat)width {
    
    if (text.length == 0)
        return [NSArray array];
    
    BOOL isCountinue = YES;
    NSMutableArray<NSString *> *lineTexts = [NSMutableArray array];
    NSString *targetString = text.copy;
    while (isCountinue) {
        
        NSArray *strings = [self label_handlerLineContentWithText:targetString lineWidth:width];
        targetString = strings.lastObject;
        [lineTexts addObject:strings.firstObject];
        if (targetString.length == 0) {
            
            isCountinue = NO;
            
        }
    }
    
    //需求二：最后一行不能只有一个字。如果是一个字，那么从上一行摘最后一个字符补上。
    if (lineTexts.lastObject.length == 1 && lineTexts.count >= 2 && self.style == DDQTextLayoutLabelStyleLastLineNotOneChar) {
        
        NSMutableString *lastString = lineTexts[lineTexts.count - 2].mutableCopy;
        
        __block NSRange subRange = NSMakeRange(lastString.length - 1, 1);
        __block NSString *remaindStr = [lastString substringWithRange:subRange];
        
        if ([self label_checkIsNumber:remaindStr]) {//如果是数字的话，很有可能把数字给拆散了
            
            //在这里，不好判断数字出现的loction和length。
            //这里也不需要判断特殊字符结尾的问题，简单点就是再枚举看一次。
            [lastString enumerateSubstringsInRange:NSMakeRange(0, lastString.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                
                if (substringRange.location + substringRange.length == lastString.length) {//最后的word
                    
                    remaindStr = substring;
                    subRange = substringRange;
                    
                }
            }];
            
            NSString *signStr = [lastString substringWithRange:NSMakeRange(subRange.location - 1, 1)];
            if ([signStr isEqualToString:@"-"] || [signStr isEqualToString:@"+"]) {//这里的意思是有可能出现”-100“这种带符号数字的情况，并且肯定也是连着用的，往前找一个就好了
                
                remaindStr = [signStr stringByAppendingString:remaindStr];
                subRange = NSMakeRange(subRange.location - 1, subRange.length + 1);
                
            }
            
            NSString *newString = [remaindStr stringByAppendingString:lineTexts.lastObject];
            [lineTexts replaceObjectAtIndex:lineTexts.count - 1 withObject:newString];
            
            [lastString deleteCharactersInRange:subRange];
            [lineTexts replaceObjectAtIndex:lineTexts.count - 2 withObject:lastString.copy];
            
        } else {
            
            NSString *newString = [remaindStr stringByAppendingString:lineTexts.lastObject];
            [lineTexts replaceObjectAtIndex:lineTexts.count - 1 withObject:newString];
            
            [lastString deleteCharactersInRange:subRange];
            [lineTexts replaceObjectAtIndex:lineTexts.count - 2 withObject:lastString.copy];
            
        }
    }
    
    return lineTexts.copy;
    
}

/**
 核心计算流程
 
 @param text 计算的文本
 @param width 显示的最大宽度
 @return 数组。元素个数为2，首元素为固定宽度下能够显示的最多文本，末元素为截取后的剩余字符串
 */
- (NSArray<NSString *> *)label_handlerLineContentWithText:(NSString *)text lineWidth:(CGFloat)width {
    
    __block CGFloat totalLength = 0.0;
    NSMutableString *containerString = [NSMutableString string];
    __block NSInteger lastIndex = 0;//用来记录上一次计算时开始的range
    __block BOOL finishIsNumber = NO;
    /*
     优点：
     ①、系统枚举在性能上会强于for循环，而且循环次数也会小于for循环次数
     ②、ByWords能够自动区分词组、数字、英文、甚至于：😁，因此文本计算次数也会少点。而且适合我的数字换行的需求
     
     缺点：
     他会跳过特殊字符，比如：@#$%^&(*()_+-=·！。只认识-，_这两个。
     这导致在计算过程中会比较麻烦
     
     */
    [text enumerateSubstringsInRange:NSMakeRange(0, text.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        NSString *targetString = substring;
        //表示这次的字符的起点，减去上一次字符的总长度应该为0。不为0的话表示跳过了某些字符
        NSInteger remaindLength = substringRange.location - lastIndex;
        if (remaindLength >= 1) {//如果跳过了某些字符，那么本次先处理这些跳过的字符
            
            NSString *jumpString = [text substringWithRange:NSMakeRange(lastIndex, remaindLength)];
            CGSize jumpSize = [self label_boundTextSizeWithText:jumpString width:width];
            totalLength += jumpSize.width;
            if (totalLength > width) {//计算的总长度是否大于允许的最大宽度。
                
                totalLength -= jumpSize.width;
                //遍历跳过的字符串
                [jumpString enumerateSubstringsInRange:NSMakeRange(0, jumpString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                    
                    //一个字一个字的拆解，计算，拼接
                    CGSize remaindSize = [self label_boundTextSizeWithText:substring width:width];
                    totalLength += remaindSize.width;
                    if (totalLength > width) {//还是得验证是否超长
                        
                        totalLength -= remaindSize.width;
                        *stop = YES;
                        
                    } else {
                        
                        [containerString appendString:substring];
                        lastIndex = containerString.length;
                        
                    }
                }];
            } else {
                
                [containerString appendString:jumpString];
                lastIndex = containerString.length;
                
            }
        }
        
        //本次遍历的字符串
        CGSize subSize = [self label_boundTextSizeWithText:substring width:width];
        totalLength += subSize.width;
        if (totalLength > width) {//本次计算后，文本是否超长
            
            totalLength -= subSize.width;
            if ([self label_checkIsNumber:targetString] && self.lineBreakMode == NSLineBreakByWordWrapping) {//结尾为数字且设置成wordWrapping时就折行
                
                finishIsNumber = YES;
                *stop = YES;
                
            } else {
                
                //否则拆解拼接，流程同上
                [targetString enumerateSubstringsInRange:NSMakeRange(0, targetString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                    
                    CGSize remaindSize = [self label_boundTextSizeWithText:substring width:width];
                    totalLength += remaindSize.width;
                    if (totalLength > width) {
                        
                        totalLength -= remaindSize.width;
                        *stop = YES;
                        
                    } else {
                        
                        [containerString appendString:substring];
                        lastIndex = containerString.length;
                        
                    }
                }];
                *stop = YES;

            }
        } else {
            
            [containerString appendString:targetString];
            lastIndex = containerString.length;
            
        }
    }];
    
    //正如上面提到的他会跳过特殊字符。那么特殊字符很有可能出现在最后，比如：“。”结尾
    NSString *remaindString = @"";
    if (!finishIsNumber) {//如果是数字换行，则不用考虑特殊字符结尾的情况
        
        remaindString = [text substringWithRange:NSMakeRange(containerString.length, text.length - containerString.length)];
        //再把剩下的字符串单独进行计算，能够显示下的话就直接拼回去
        [remaindString enumerateSubstringsInRange:NSMakeRange(0, remaindString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            
            CGSize remaindSize = [self label_boundTextSizeWithText:substring width:width];;
            totalLength += remaindSize.width;
            if (totalLength > width) {
                
                totalLength -= remaindSize.width;
                *stop = YES;
                
            } else {
                
                [containerString appendString:substring];
                
            }
        }];
    }
    
    NSString *subString = containerString.copy;
    remaindString = [text substringWithRange:NSMakeRange(subString.length, text.length - subString.length)];
    
    return @[subString, remaindString];
    
}

/**
 计算文本的大小
 
 @param text 文字内容
 @return 大小
 */
- (CGSize)label_boundTextSizeWithText:(NSString *)text width:(CGFloat)width {
    
    return [text boundingRectWithSize:CGSizeMake(width, 50.0) options:NSStringDrawingUsesFontLeading attributes:self.displayAttributes.copy context:nil].size;
    
}

@end
