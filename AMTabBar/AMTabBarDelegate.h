//
//  AMTabBarDelegate.h
//  Demo
//
//  Created by HuangYiFeng on 10/15/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMTabBar;

@protocol AMTabBarDelegate <NSObject>

-(void)tabBar:(AMTabBar *)tabBar didSelectIndex:(NSInteger)index;

@end
