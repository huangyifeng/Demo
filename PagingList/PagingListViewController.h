//
//  PagingListViewController.h
//  Demo
//
//  Created by HuangYiFeng on 9/4/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagingListViewController : UIViewController <UIScrollViewDelegate>
{
    //view
    UIScrollView    *_scrollView;
    
    //model
    NSInteger _currentPageIndex;
    NSUInteger _pageCount;
    NSMutableDictionary *_controllerCache;
    
}

//for override
- (UIViewController *)controllerWithPage:(NSInteger)pageIndex;
- (NSInteger)getTotalPageCount;

@end
