//
//  PagingListViewController.h
//  Demo
//
//  Created by HuangYiFeng on 9/4/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    PagingListLoadNeighbor,
    PagingListLoadOnlySelf
}PagingListLoadPolicy;

@interface PagingListViewController : UIViewController <UIScrollViewDelegate>
{
    //view
    UIScrollView    *_scrollView;
    
    //model
    NSInteger               _currentPageIndex;
    NSUInteger              _pageCount;
    NSMutableDictionary     *_controllerCache;
    PagingListLoadPolicy    _loadPolicy;
    
}

@property(nonatomic, assign)PagingListLoadPolicy loadPolicy;

//for override
- (UIViewController *)controllerWithPage:(NSInteger)pageIndex;
- (NSInteger)getTotalPageCount;
- (void)pageChanged:(NSInteger)pageIndex;

//public
- (void)scrollTo:(NSInteger)pageIndex;
- (void)scrollTo:(NSInteger)pageIndex animated:(BOOL)animated;
- (NSInteger)currentPageIndex;


@end
