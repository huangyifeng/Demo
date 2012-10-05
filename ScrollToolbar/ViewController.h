//
//  ViewController.h
//  ScrollToolbar
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollToolbarDelegate.h"

@interface ViewController : UIViewController <ScrollToolbarDataSource, ScrollToolbarDelegate>
{
@private
    NSArray  *_scrollToolbarItems;
}

@end
