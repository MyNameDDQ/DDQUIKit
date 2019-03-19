//
//  DDQCell.m
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/18.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import "DDQCell.h"

#import <DDQAutoLayout/DDQAutoLayout.h>

@interface DDQCell ()

@property (nonatomic, strong) UIView *separator;
@property (nonatomic, readwrite) BOOL cell_configSubviews;
@property (nonatomic, readwrite) BOOL cell_layoutSubviews;

@end

@implementation DDQCell

const DDQSeparatorMargin DDQSeparatorMarginZero = {0, 0};

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self cell_initializeConfig];
    [self cell_foundationConfigSubviews];
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    [self cell_initializeConfig];
    [self cell_foundationConfigSubviews];
    
    return self;
    
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.cell_layoutSubviews = YES;
    
    DDQAutoLayoutMaker(self.separator).
    DDQLeft(self.contentView.ddqLeft, self.cell_separatorMargin.leftMargin).
    DDQSize(CGSizeMake(self.contentView.ddqWidth - self.cell_separatorMargin.leftMargin - self.cell_separatorMargin.rightMargin, self.cell_separatorHeight));
    
    if (self.cell_separatorStyle == DDQCellSeparatorStyleBottom) {
        
        DDQAutoLayoutMaker(self.separator).DDQBottom(self.contentView.ddqBottom, 0.0);
        
    } else if (self.cell_separatorStyle == DDQCellSeparatorStyleTop) {
        
        
        DDQAutoLayoutMaker(self.separator).DDQTop(self.contentView.ddqTop, 0.0);
        
    }
    
    [self cell_foundationCellFrameDidUpdated];

}

- (void)setFrame:(CGRect)frame {
    
    CGRect newFrame = frame;
    if ([self.class cell_adjustsForceFitMaxWidth]) {
        
        newFrame.size.width = self.cell_preferredMaxWidth;
        
    }
    [super setFrame:frame];
    
    if ([self.class cell_callDidUpdateWhenSetFrameIfNeeds]) {
        
        [self cell_foundationCellFrameDidUpdated];
        
    }
}

/**
 初始化
 */
- (void)cell_initializeConfig {
    
    self.cell_separatorStyle = DDQCellSeparatorStyleNone;
    
    self.cell_separatorHeight = 0.5;
    
    self.cell_separatorMargin = DDQSeparatorMarginZero;
    
    self.cell_preferredMaxWidth = UIScreen.mainScreen.bounds.size.width;
    
    self.separator = [UIView ddq_controlWithBackgroundColor:self.cell_separatorColor];
    [self.contentView addSubview:self.separator];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (DDQScreenScale)cell_scale {
    
    return [self.class ddq_getScreenScaleWithType:DDQScreenVersionType6];
    
}

- (CGFloat)cell_widthScale {
    
    return self.cell_scale.widthScale;
    
}

- (void)setCell_separatorColor:(UIColor *)cell_separatorColor {
    
    _cell_separatorColor = cell_separatorColor;
    self.separator.backgroundColor = cell_separatorColor;
    
}

- (void)setCell_separatorStyle:(DDQCellSeparatorStyle)cell_separatorStyle {
    
    _cell_separatorStyle = cell_separatorStyle;
    self.separator.hidden = (_cell_separatorStyle == DDQCellSeparatorStyleNone) ? YES : NO;
    
    if (self.cell_layoutSubviews) {
        
        [self setNeedsLayout];
        
    }
}

- (void)setCell_separatorHeight:(CGFloat)cell_separatorHeight {
    
    _cell_separatorHeight = cell_separatorHeight;
    if (self.cell_layoutSubviews) {
        
        [self setNeedsLayout];
        
    }
}

- (void)setCell_separatorMargin:(DDQSeparatorMargin)cell_separatorMargin {
    
    _cell_separatorMargin = cell_separatorMargin;
    if (self.cell_layoutSubviews) {
        
        [self setNeedsLayout];

    }
}

- (void)cell_foundationConfigSubviews {
    
    self.cell_configSubviews = YES;
    
}

- (void)cell_foundationCellFrameDidUpdated {}

+ (BOOL)cell_callDidUpdateWhenSetFrameIfNeeds {
    return NO;
}

+ (BOOL)cell_adjustsForceFitMaxWidth {
    return YES;
}

@end
