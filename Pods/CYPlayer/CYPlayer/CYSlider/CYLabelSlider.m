//
//  CYLabelSlider.m
//  CYSlider
//
//  Created by yellowei on 2017/11/20.
//  Copyright © 2017年 yellowei. All rights reserved.
//

#import "CYLabelSlider.h"
#import <Masonry/Masonry.h>

@interface CYLabelSlider ()

@end

@implementation CYLabelSlider
@synthesize leftLabel = _leftLabel;
@synthesize rightlabel = _rightlabel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _labelSetupView];
    return self;
}

- (void)_labelSetupView {
    [self.leftContainerView addSubview:self.leftLabel];
    [self.rightContainerView addSubview:self.rightlabel];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_leftLabel.superview);
    }];
    
    [_rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_rightlabel.superview);
    }];
}

- (UILabel *)leftLabel {
    if ( _leftLabel ) return _leftLabel;
    _leftLabel = [self _createLabel];
    return _leftLabel;
}

- (UILabel *)rightlabel {
    if ( _rightlabel ) return _rightlabel;
    _rightlabel = [self _createLabel];
    return _rightlabel;
}

- (UILabel *)_createLabel {
    UILabel *label = [UILabel new];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"00";
    [label sizeToFit];
    return label;
}
@end
