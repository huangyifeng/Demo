//
//  ScrollToolbar.h
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollToolbarDelegate.h"


@interface ScrollToolbar : UIView
{
    UIScrollView    *_scrollView;
    UIView          *_arrowView;
    id<ScrollToolbarDelegate>   _delegate;
}

@property(nonatomic, assign)id<ScrollToolbarDelegate> delegate;

@end
