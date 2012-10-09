//
//  LauncherBadgeView.h
//  LauncherView
//
//  Created by Huang YiFeng on 8/2/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LauncherBadgeView : UILabel
{
    NSUInteger  _badgeValue;
    BOOL        _hideWhenZero;
}

@property(nonatomic, assign) NSUInteger badgeValue;
@property(nonatomic, assign) BOOL       hideWhenZero;

@end
