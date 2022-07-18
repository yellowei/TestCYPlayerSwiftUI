//
//  CYPrompt.m
//  CYPromptProject
//
//  Created by yellowei on 2017/9/26.
//  Copyright © 2017年 yellowei. All rights reserved.
//

#import "CYPrompt.h"
#import <Masonry/Masonry.h>

@interface CYPrompt ()

@property (nonatomic, weak, readwrite) UIView *presentView;
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UILabel *promptLabel;
@property (nonatomic, strong, readonly) CYPromptConfig *config;

@end

@implementation CYPrompt

@synthesize backgroundView = _backgroundView;
@synthesize promptLabel = _promptLabel;
@synthesize config = _config;

+ (instancetype)promptWithPresentView:(__weak UIView *)presentView {
    return [[CYPrompt alloc] initWithPresentView:presentView];
}

- (instancetype)initWithPresentView:(__weak UIView *)presentView {
    self = [super init];
    if ( !self ) return self;
    NSAssert(presentView, @"presentView can not be empty!");
    _presentView = presentView;
    [self _setupView];
    self.update(^(CYPromptConfig * _Nonnull config) {/**/});
    return self;
}

- (void (^)(void (^ _Nonnull)(CYPromptConfig * _Nonnull)))update {
    __weak typeof(self) _self = self;
    return ^void(void(^block)(CYPromptConfig *config)) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        if ( block ) block(self.config);
        self.promptLabel.font = self.config.font;
        self.promptLabel.textColor = self.config.fontColor;
        self.backgroundView.backgroundColor = self.config.backgroundColor;
        self.backgroundView.layer.cornerRadius = self.config.cornerRadius;
        [self.promptLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(self.config.insets);
        }];
    };
}

- (void)reset {
    [self.config reset];
}

- (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration {
    if ( !_presentView ) return;
    CGFloat maxWdith = 0 != self.config.maxWidth ? self.config.maxWidth : _presentView.frame.size.width * 0.6;
    CGSize size = [self _sizeForTitle:title constraints:CGSizeMake(maxWdith, CGFLOAT_MAX)];
    [_backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.equalTo(@(size.width + self.config.insets.left + self.config.insets.right));
        make.height.equalTo(@(size.height + self.config.insets.top + + self.config.insets.bottom));
    }];
    
    _promptLabel.text = title;
    [self _show];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_hidden) object:nil];
    if ( duration == - 1 ) return;
    [self performSelector:@selector(_hidden) withObject:nil afterDelay:duration];
}

- (void)hidden {
    [self _hidden];
}

- (void)_show {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 1;
    }];
}

- (void)_hidden {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.001;
    }];
}

- (void)_setupView {
    [_presentView addSubview:self.backgroundView];
    [_backgroundView addSubview:self.promptLabel];
//    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.offset(0);
//    }];
}

- (UIView *)backgroundView  {
    if ( _backgroundView ) return _backgroundView;
    _backgroundView = [UIView new];
    _backgroundView.clipsToBounds = YES;
    _backgroundView.alpha = 0.001;
    return _backgroundView;
}

- (UILabel *)promptLabel {
    if ( _promptLabel ) return _promptLabel;
    _promptLabel = [UILabel new];
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.numberOfLines = 0;
    return _promptLabel;
}

- (CYPromptConfig *)config {
    if ( _config ) return _config;
    _config = [CYPromptConfig new];
    return _config;
}

- (CGSize)_sizeForTitle:(NSString *)title constraints:(CGSize)size {
    CGSize result;
    if ( [title respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)] ) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = self.config.font;
        CGRect rect = [title boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [title sizeWithFont:self.config.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    return CGSizeMake(ceil(result.width + 5), ceil(result.height));
}

@end
