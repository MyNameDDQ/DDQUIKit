//
//  DDQView.m
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQView.h"

@interface DDQView ()

@property (nonatomic, readwrite) BOOL view_configSubviews;
@property (nonatomic, readwrite) BOOL view_layoutSubviews;

@end

@implementation DDQView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    [self view_foundationConfigSubviews];

    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (!self) {
        return nil;
    }
    [self view_foundationConfigSubviews];

    return self;
    
}

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    [self view_foundationConfigSubviews];
    
    return self;
    
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
    
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    if ([self.class view_callDidUpdateWhenSetFrameIfNeeds]) {
        
        [self view_foundationViewFrameDidUpdate];
        
    }
}

- (void)view_foundationConfigSubviews {
    
    self.view_configSubviews = YES;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.view_layoutSubviews = YES;
    [self view_foundationViewFrameDidUpdate];
    
}

- (DDQScreenScale)view_scale {
    
    return [self.class ddq_getScreenScaleWithType:DDQScreenVersionType6];
    
}

- (CGFloat)view_widthScale {
    
    return self.view_scale.widthScale;
    
}

- (void)view_foundationViewFrameDidUpdate {}

+ (BOOL)view_callDidUpdateWhenSetFrameIfNeeds {
    
    return NO;
    
}

@end
