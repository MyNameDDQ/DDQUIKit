//
//  UIView+DDQLayoutGuide.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQScreenVersionType) {
    
    DDQScreenVersionTypeNormal,    //默认的设备型号
    DDQScreenVersionType4,         //4屏幕比例大小(包含：4s) 屏幕尺寸：320 * 480
    DDQScreenVersionType5,         //5屏幕比例大小(包含：5,5c,5s,SE) 屏幕尺寸：320 * 568
    DDQScreenVersionType6,         //6屏幕比例大小(包含：6,7,8)  屏幕尺寸：375 * 667
    DDQScreenVersionTypePlus,      //6p屏幕比例大小(包含：6p,7p,8p)  屏幕尺寸：414 * 736
    DDQScreenVersionTypeX,         //iPhoneX 和iPhoneXS一样都为5.8英寸屏 屏幕尺寸：375 * 812
    DDQScreenVersionTypeXsMax      //XS和XR皆可按 屏幕尺寸：414 * 896适配
    
};

typedef NS_ENUM(NSUInteger, DDQScreenVersionTypeForPad) {
    
    DDQScreenVersionTypeForPadNormal,           //默认设备型号，以9.7英寸为主
    DDQScreenVersionTypeForPad9_7Inch,          //1536 * 2048
    DDQScreenVersionTypeForPad10_5Inch,         //1668 * 2224。11寸屏也可以用这个
    DDQScreenVersionTypeForPad12_9Inch,         //2048 * 2732
    
} NS_AVAILABLE_IOS(1_0_3);

struct DDQScreenScale {
    
    CGFloat widthScale;
    CGFloat heightScale;
    
};
typedef struct DDQScreenScale DDQScreenScale;

UIKIT_STATIC_INLINE DDQScreenScale DDQScreenScaleMaker(CGFloat w, CGFloat h);
UIKIT_STATIC_INLINE NSString * _Nonnull DDQStringFromScale(DDQScreenScale scale);

UIKIT_STATIC_INLINE UIFont * _Nonnull DDQFontWithSize(CGFloat fSize);
UIKIT_STATIC_INLINE UIImage * _Nullable DDQImageWithName(NSString *_Nullable name);

UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithRGB(CGFloat r, CGFloat g, CGFloat b);
UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);//A->alpha,C->component
UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithRGBC(CGFloat r, CGFloat g, CGFloat b, CGFloat c);
UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithRGBAC(CGFloat r, CGFloat g, CGFloat b, CGFloat a, CGFloat c);

UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithHex(NSString *hex);
UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithHexA(NSString *hex, CGFloat a);
UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithHexC(NSString *hex, CGFloat c);
UIKIT_STATIC_INLINE UIColor * _Nonnull DDQColorWithHexAC(NSString *hex, CGFloat a, CGFloat c);

@interface UIView (DDQLayoutGuide)

@property (nonatomic, readonly) CGSize ddqSize;
@property (nonatomic, readonly) CGFloat ddqX;
@property (nonatomic, readonly) CGFloat ddqY;
@property (nonatomic, readonly) CGFloat ddqWidth;
@property (nonatomic, readonly) CGFloat ddqHeight;
@property (nonatomic, readonly) CGFloat ddqBoundsMidX;
@property (nonatomic, readonly) CGFloat ddqBoundsMidY;
@property (nonatomic, readonly) CGFloat ddqFrameMaxX;
@property (nonatomic, readonly) CGFloat ddqFrameMaxY;
@property (nonatomic, readonly) CGFloat ddqFrameMidX;
@property (nonatomic, readonly) CGFloat ddqFrameMidY;

/**
 获取当前屏幕宽高比
 
 @param type 以什么设备为比例基础
 @return 宽高比
 */
+ (DDQScreenScale)ddq_getScreenScaleWithType:(DDQScreenVersionType)type;

/**
 获取当前pad屏幕宽高比

 @param type 以什么设备为比例基础
 @return 宽高比
 */
+ (DDQScreenScale)ddq_getScreenScaleWithTypeForPad:(DDQScreenVersionTypeForPad)type NS_AVAILABLE_IOS(1_0_3);

/**
 获取当前设备的型号
 */
+ (DDQScreenVersionType)ddq_getScreenScaleType;

@end

#pragma mark - Function IMP
UIKIT_STATIC_INLINE DDQScreenScale DDQScreenScaleMaker(CGFloat w, CGFloat h) {
    
    DDQScreenScale scale; scale.widthScale = w; scale.heightScale = h; return scale;
    
}

UIKIT_STATIC_INLINE NSString * _Nonnull DDQStringFromScale(DDQScreenScale scale) {
    
    return [NSString stringWithFormat:@"<widthScale = %f; heightScale = %f>", scale.widthScale, scale.heightScale];
    
}

UIKIT_STATIC_INLINE UIFont * DDQFontWithSize(CGFloat fSize) {
    
    return [UIFont systemFontOfSize:fSize];
    
}

UIKIT_STATIC_INLINE UIImage * DDQImageWithName(NSString *_Nullable name) {
    
    return name.length == 0 || !name ? [[UIImage alloc] init] : [UIImage imageNamed:name];
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithRGB(CGFloat r, CGFloat g, CGFloat b) {
    
    return DDQColorWithRGBAC(r, g, b, 1.0, 1.0);
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    
    return DDQColorWithRGBAC(r, g, b, a, 1.0);
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithRGBC(CGFloat r, CGFloat g, CGFloat b, CGFloat c) {
    
    return DDQColorWithRGBAC(r, g, b, 1.0, c);
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithRGBAC(CGFloat r, CGFloat g, CGFloat b, CGFloat a, CGFloat c) {
    
    return [[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a] colorWithAlphaComponent:c];
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithHex(NSString *hex) {
    
    return DDQColorWithHexAC(hex, 1.0, 1.0);
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithHexA(NSString *hex, CGFloat a) {
    
    return DDQColorWithHexAC(hex, a, 1.0);
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithHexC(NSString *hex, CGFloat c) {
    
    return DDQColorWithHexAC(hex, 1.0, c);
    
}

UIKIT_STATIC_INLINE UIColor * DDQColorWithHexAC(NSString *hex, CGFloat a, CGFloat c) {
    
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        
        return [UIColor clearColor];
        
    }
    
    if ([cString hasPrefix:@"0X"]) {
        
        cString = [cString substringFromIndex:2];
        
    }
    
    if ([cString hasPrefix:@"#"]) {
        
        cString = [cString substringFromIndex:1];
        
    }
    
    if ([cString length] != 6) {
        
        return [UIColor clearColor];
        
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return DDQColorWithRGBAC(r, g, b, a, c);
    
}


NS_ASSUME_NONNULL_END
