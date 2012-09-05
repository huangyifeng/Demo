//
//  SinglePageViewController.h
//  Demo
//
//  Created by HuangYiFeng on 9/5/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePageViewController : UIViewController
{
@private
    NSInteger   _data;
}

@property(nonatomic, assign)NSInteger   data;

@property(nonatomic, retain)IBOutlet UILabel *dataLabel;

@end
