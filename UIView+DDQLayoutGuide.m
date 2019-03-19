//
//  UIView+DDQLayoutGuide.m
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "UIView+DDQLayoutGuide.h"

@implementation UIView (DDQLayoutGuide)

- (CGFloat)ddqX {
    
    return CGRectGetMinX(self.frame);
    
}

- (CGFloat)ddqY {
    
    return CGRectGetMinY(self.frame);
    
}

- (CGFloat)ddqWidth {
    
    return CGRectGetWidth(self.frame);
    
}

- (CGFloat)ddqHeight {
    
    return CGRectGetHeight(self.frame);
    
}

- (CGFloat)ddqBoundsMidX {
    
    return CGRectGetMidX(self.bounds);
    
}

- (CGFloat)ddqBoundsMidY {
    
    return CGRectGetMidY(self.bounds);
    
}

- (CGFloat)ddqFrameMidX {
    
    return CGRectGetMidX(self.frame);
    
}

- (CGFloat)ddqFrameMidY {
    
    return CGRectGetMidY(self.frame);
    
}

- (CGFloat)ddqFrameMaxX {
    
    return CGRectGetMaxX(self.frame);
    
}

- (CGFloat)ddqFrameMaxY {
    
    return CGRectGetMaxY(self.frame);
    
}

- (CGSize)ddqSize {
    
    return self.frame.size;
    
}

+ (DDQScreenVersionType)ddq_getScreenScaleType {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (screenWidth == 320) {//4,4s,5系列还有se
        
        return (screenHeight == 480) ? DDQScreenVersionType4 : DDQScreenVersionType5;
        
    }
    
    if (screenWidth == 375) {//6,7,8,X
        
        return (screenHeight == 812) ? DDQScreenVersionTypeX : DDQScreenVersionType6;
        
    }
    
    if (screenWidth == 414) {//6p,7p,8p,max
        
        return (screenHeight == 896) ? DDQScreenVersionTypeXsMax : DDQScreenVersionTypePlus;
        
    }

    return DDQScreenVersionTypeNormal;
    
}

+ (DDQScreenScale)ddq_getScreenScaleWithType:(DDQScreenVersionType)type {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat wScale = screenWidth / 375.0;
    CGFloat hScale = screenHeight / 667.0;
    
    switch (type) {
            
        case DDQScreenVersionType4:
            wScale = screenWidth / 320.0;
            hScale = screenHeight / 480.0;
            break;
            
        case DDQScreenVersionType5:
            wScale = screenWidth / 320.0;
            hScale = screenHeight / 568.0;
            break;

        case DDQScreenVersionType6:
            wScale = screenWidth / 375.0;
            hScale = screenHeight / 667.0;
            break;

        case DDQScreenVersionTypePlus:
            wScale = screenWidth / 414.0;
            hScale = screenHeight / 736.0;
            break;

        case DDQScreenVersionTypeX:
            wScale = screenWidth / 375.0;
            hScale = screenHeight / 812.0;
            break;

        case DDQScreenVersionTypeXsMax:
            wScale = screenWidth / 414.0;
            hScale = screenHeight / 896.0;
            break;
            
        default:
            break;
    }
    
    return BQScreenScaleMaker(wScale, hScale);
    
}

@end
