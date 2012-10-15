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
    //view
    UIView                  *_selectedDot;
    
    //model
    NSArray                 *_titles; //string
    id<AMTabBarDelegate>    _delegate;
    NSArray                 *_buttons; //UIButton
    NSInteger               _selectedIndex;
}

@property(nonatomic, retain)NSArray                 *titles;
@property(nonatomic, retain)IBOutlet id<AMTabBarDelegate>    delegate;
@property(nonatomic, assign)NSInteger               selectedIndex;

- (void)renderWithTitles:(NSArray *)titles;

@end
