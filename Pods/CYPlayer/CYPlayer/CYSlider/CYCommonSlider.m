//
//  CYCommonSlider.m
//  CYSlider
//
//  Created by yellowei on 2017/11/20.
//  Copyright © 2017年 yellowei. All rights reserved.
//

#import "CYCommonSlider.h"
#import <Masonry/Masonry.h>

@interface CYCommonSlider ()

@property (nonatomic, strong, readonly) UIView *containerView;

@end

@implementation CYCommonSlider
@synthesize containerView = _containerView;
@synthesize leftContainerView = _leftContainerView;
@synthesize slider = _slider;
@synthesize rightContainerView = _rightContainerView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _c_setupView];
    return self;
}

- (void)_c_setupView {
    [self addSubview:self.containerView];
    [_containerView addSubview:self.leftContainerView];
    [_containerView addSubview:self.slider];
    [_containerView addSubview:self.rightContainerView];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_leftContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.equalTo(_leftContainerView.superview);
        make.width.equalTo(_leftContainerView.mas_height);
    }];
    
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.leading.equalTo(_leftContainerView.mas_trailing).offset(4);
        make.trailing.equalTo(_rightContainerView.mas_leading).offset(-4);
    }];
    
    [_rightContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(_rightContainerView.superview);
        make.width.equalTo(_rightContainerView.mas_height);
    }];
}

- (UIView *)leftContainerView {
    if ( _leftContainerView ) return _leftContainerView;
    _leftContainerView = [UIView new];
    _leftContainerView.backgroundColor = [UIColor clearColor];
    return _leftContainerView;
}

- (CYSlider *)slider {
    if ( _slider ) return _slider;
    _slider = [CYSlider new];
    return _slider;
}

- (UIView *)rightContainerView {
    if ( _rightContainerView ) return _rightContainerView;
    _rightContainerView = [UIView new];
    _rightContainerView.backgroundColor = [UIColor clearColor];
    return _rightContainerView;
}

- (UIView *)containerView {
    if ( _containerView ) return _containerView;
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor clearColor];
    return _containerView;
}

@end
