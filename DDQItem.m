//
//  DDQItem.m
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQItem.h"

@interface DDQItem ()

@property (nonatomic, readwrite) BOOL item_layoutSubviews;

@end

@implementation DDQItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self item_foundationConfigSubviews];
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    [self item_foundationConfigSubviews];
    
    return self;
    
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.item_layoutSubviews = YES;
    
    [self item_foundationItemFrameDidUpdate];
    
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    if ([self.class item_callDidUpdateWhenSetFrameIfNeeds]) {
        
        [self item_foundationItemFrameDidUpdate];
        
    }
}

- (void)item_foundationConfigSubviews {}

- (void)item_foundationItemFrameDidUpdate {}

+ (BOOL)item_callDidUpdateWhenSetFrameIfNeeds {
    return NO;
}

- (DDQScreenScale)item_scale {
    
    return [self.class ddq_getScreenScaleWithType:DDQScreenVersionType6];
    
}

- (CGFloat)item_widthScale {
    
    return self.item_scale.widthScale;
    
}

@end
