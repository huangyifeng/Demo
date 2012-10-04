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
    //View
    UIScrollView    *_scrollView;
    UIView          *_arrowView;
    
    NSArray         *_buttons;
    
    //model
    id<ScrollToolbarDelegate>   _delegate;
    id<ScrollToolbarDataSource> _dataSource;
    NSInteger                   _numberOfButtons;
    NSInteger                   _selectedButtonIndex;
}

@property(nonatomic, assign)id<ScrollToolbarDelegate>   delegate;
@property(nonatomic, assign)id<ScrollToolbarDataSource> dataSource;


@end
