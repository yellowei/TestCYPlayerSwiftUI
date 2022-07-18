//
//  CYOrentationObserver.h
//  CYVideoPlayerProject
//
//  Created by yellowei on 2017/12/5.
//  Copyright © 2017年 yellowei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYOrentationObserver : NSObject

/*!
 *  Target is rotationView.
 *  Container is superview.
 **/
- (instancetype)initWithTarget:(__weak UIView *)view container:(__weak UIView *)targetSuperview;

@property (nonatomic, assign, readonly, getter=isFullScreen) BOOL fullScreen;
/// 旋转时间, default is 0.3
@property (nonatomic, assign, readwrite) float duration;
/// 旋转条件, 返回 YES 才会旋转, 默认为 nil.
@property (nonatomic, copy, readwrite, nullable) BOOL(^rotationCondition)(CYOrentationObserver *observer);

@property (nonatomic, copy, readwrite, nullable) void(^orientationChanged)(CYOrentationObserver *observer);

- (BOOL)_changeOrientation;

@end

NS_ASSUME_NONNULL_END
