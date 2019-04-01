//
//  DDQButton.m
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/31.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQButton.h"

#import <DDQAutoLayout/DDQAutoLayout.h>

@interface DDQButton ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) DDQButtonStyle style;

@end

@implementation DDQButton

- (instancetype)initWithButtonStyle:(DDQButtonStyle)style {
    
    self = [super initWithFrame:CGRectZero];
    
    if (!self) {
        return nil;
    }
    
    self.style = style;
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithButtonStyle:DDQButtonStyleImageTop];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (!self) {
        return nil;
    }
    
    self.style = DDQButtonStyleImageTop;
    
    return self;
    
}

- (void)view_foundationConfigSubviews {
    
    self.backgroundImageView = [UIImageView ddq_imageView];
    self.imageView = [UIImageView ddq_imageView];
    self.titleLabel = [UILabel ddq_label];
    
    [self ddq_addSubviews:@[self.backgroundImageView, self.imageView, self.titleLabel]];
    
    self.layoutInsets = UIEdgeInsetsZero;
    self.controlSpace = 5.0;
    self.imageSize = CGSizeZero;
    
    self.clipsToBounds = YES;
    
}

- (void)sizeToFit {
    
    CGSize fitSize = [self sizeThatFits:CGSizeMake(UIScreen.mainScreen.bounds.size.width, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size = fitSize;
    self.frame = frame;
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize boundSize = CGSizeZero;
    
    CGSize imageSize = CGSizeEqualToSize(CGSizeZero, self.imageSize) ? self.imageView.image.size : self.imageSize;
    CGFloat maxWidth = size.width - self.layoutInsets.left - self.layoutInsets.right;
    
    switch (self.style) {
            
        case DDQButtonStyleImageTop: {
            
            boundSize.height = self.layoutInsets.top + imageSize.height;
            
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth, size.height - boundSize.height - self.controlSpace)];
            
            boundSize.height = self.layoutInsets.top + titleSize.height + self.controlSpace + imageSize.height + self.layoutInsets.bottom;
            boundSize.width = MAX(titleSize.width, imageSize.width);

        } break;
            
        case DDQButtonStyleImageBottom: {
            
            CGFloat maxHeight = size.height - imageSize.height - self.controlSpace - self.layoutInsets.top - self.layoutInsets.bottom;
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth, maxHeight)];
            titleSize.height = MIN(titleSize.height, maxHeight);

            boundSize.height = self.layoutInsets.top + titleSize.height + self.controlSpace + imageSize.height + self.layoutInsets.bottom;
            boundSize.width = MAX(titleSize.width, imageSize.width);
            
        } break;

        case DDQButtonStyleImageLeft: {
            
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth - imageSize.width - self.controlSpace, size.height - self.layoutInsets.top - self.layoutInsets.bottom)];
            
            boundSize.width = self.layoutInsets.left + imageSize.width + self.controlSpace + titleSize.width + self.layoutInsets.right;
            boundSize.height = (MAX(titleSize.height, imageSize.height) + self.layoutInsets.top + self.layoutInsets.bottom);

        } break;
            
        case DDQButtonStyleImageRight: {
            
            CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth - imageSize.width - self.controlSpace, size.height - self.layoutInsets.top - self.layoutInsets.bottom)];

            boundSize.width = self.layoutInsets.left + imageSize.width + self.controlSpace + titleSize.width + self.layoutInsets.right;
            boundSize.height = (MAX(titleSize.height, imageSize.height) + self.layoutInsets.top + self.layoutInsets.bottom);
            
        } break;
            
        default:
            break;
    }
    
    return boundSize;
    
}

- (void)view_foundationViewFrameDidUpdate {
    
    [super view_foundationViewFrameDidUpdate];
    
    self.backgroundImageView.frame = self.bounds;
    
    DDQAutoLayout *imageLayout = DDQAutoLayoutMaker(self.imageView);
    CGSizeEqualToSize(self.imageSize, CGSizeZero) ? imageLayout.DDQFitSize() : imageLayout.DDQSize(self.imageSize);
    switch (self.style) {
            
        case DDQButtonStyleImageTop: {
            
            imageLayout.DDQCenterX(self.ddqCenterX, 0.0).DDQTop(self.ddqTop, self.layoutInsets.top);
            DDQAutoLayoutMaker(self.titleLabel).DDQTop(self.imageView.ddqBottom, self.controlSpace).DDQCenterX(self.imageView.ddqCenterX, 0.0).DDQEstimateSize(CGSizeMake(self.ddqWidth - self.layoutInsets.left - self.layoutInsets.right, self.ddqHeight - self.titleLabel.ddqY - self.layoutInsets.bottom));
            
        } break;
            
        case DDQButtonStyleImageLeft: {
            
            imageLayout.DDQLeft(self.ddqLeft, self.layoutInsets.left).DDQCenterY(self.ddqCenterY, 0.0);
            DDQAutoLayoutMaker(self.titleLabel).DDQLeft(self.imageView.ddqRight, self.controlSpace).DDQCenterY(self.imageView.ddqCenterY, 0.0).DDQEstimateSize(CGSizeMake(self.ddqWidth - self.titleLabel.ddqX - self.layoutInsets.right, self.ddqHeight - self.layoutInsets.top - self.layoutInsets.bottom));
            
        } break;
            
        case DDQButtonStyleImageBottom: {
            
            imageLayout.DDQBottom(self.ddqBottom, self.layoutInsets.bottom).DDQCenterX(self.ddqCenterX, 0.0);
            DDQAutoLayoutMaker(self.titleLabel).DDQBottom(self.imageView.ddqTop, self.controlSpace).DDQCenterX(self.imageView.ddqCenterX, 0.0).DDQEstimateSize(CGSizeMake(self.ddqWidth - self.layoutInsets.left - self.layoutInsets.right, self.imageView.ddqY - self.controlSpace - self.layoutInsets.top));
            
        } break;
            
        case DDQButtonStyleImageRight: {
            
            imageLayout.DDQRight(self.ddqRight, self.layoutInsets.right).DDQCenterY(self.ddqCenterY, 0.0);
            DDQAutoLayoutMaker(self.titleLabel).DDQRight(self.imageView.ddqLeft, self.controlSpace).DDQCenterY(self.imageView.ddqCenterY, 0.0).DDQEstimateSize(CGSizeMake(self.imageView.ddqX - self.controlSpace - self.layoutInsets.left, self.ddqHeight - self.layoutInsets.top - self.layoutInsets.bottom));
            
        } break;
            
        default:
            break;
    }
}

#pragma mark - Custom Method
- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
    
}

- (void)setImage:(UIImage *)image {
    
    self.imageView.image = image;
    
}

- (void)setBackgroundImage:(UIImage *)bImage {
    
    self.backgroundImageView.image = bImage;
    
}

- (void)setTitleFont:(UIFont *)font {
    
    self.titleLabel.font = font;

}

- (void)setTitleColor:(UIColor *)color {
    
    self.titleLabel.textColor = color;

}

- (void)setAttributeTitle:(NSAttributedString *)attribute {
    
    self.titleLabel.attributedText = attribute;
    
}

@end
