//
//  ViewController.h
//  AMTabBar
//
//  Created by HuangYiFeng on 10/15/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMTabBar.h"

@interface ViewController : UIViewController <AMTabBarDelegate>
{
@private
    NSArray *_dataArray;
}

@property(nonatomic, retain)IBOutlet AMTabBar  *tabBar;
@property(nonatomic, retain)IBOutlet UILabel   *displayLabel;

@end
