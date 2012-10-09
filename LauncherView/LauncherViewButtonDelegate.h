//
//  LauncherViewButtonDelegate.h
//  Gemini
//
//  Created by Huang YiFeng on 7/25/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LauncherViewButton;

@protocol LauncherViewButtonDelegate <NSObject>

- (void)launcherViewButtonDidTapDeleteButton:(LauncherViewButton *)button;
- (void)launcherViewButton:(LauncherViewButton *)button didPan:(UIPanGestureRecognizer *)panGes;
- (void)launcherViewButton:(LauncherViewButton *)button didLongPress:(UILongPressGestureRecognizer *)longPressGes;

@end
