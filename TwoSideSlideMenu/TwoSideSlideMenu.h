//
//  TwoSideSlideMenu.h
//  Demo
//
//  Created by huang yifeng on 12-11-6.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoSideSlideMenu : UIViewController
{
@private
    UIViewController    *_frontController;
    UIViewController    *_leftController;
    UIViewController    *_rightController;
}

@end
