//
//  AMTabBar.h
//  Demo
//
//  Created by HuangYiFeng on 10/15/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMTabBarDelegate.h"

@interface AMTabBar : UIView
{
    NSArray                 *_titles; //string
    id<AMTabBarDelegate>    _delegate;
    NSArray                 *_buttons; //UIButton
}

@property(nonatomic, retain)NSArray                 *titles;
@property(nonatomic, retain)id<AMTabBarDelegate>    delegate;

- (void)renderWithTitles:(NSArray *)titles;

@end
