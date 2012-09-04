//
//  PagingListViewController.m
//  Demo
//
//  Created by HuangYiFeng on 9/4/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "PagingListViewController.h"

@interface PagingListViewController ()

//view
@property(nonatomic, retain)UIScrollView *_scrollView;

//model
@property(nonatomic, assign)NSInteger           _currentPageIndex;
@property(nonatomic, assign)NSUInteger           _pageCount;
@property(nonatomic, retain)NSMutableDictionary *_controllerCache;

- (void)initViewComponent;
- (void)initModalComponent;
- (void)loadScrollViewWithPage:(NSInteger)pageIndex;

@end

@implementation PagingListViewController

@synthesize _scrollView = _scrollView;

@synthesize _currentPageIndex = _currentPageIndex;
@synthesize _pageCount        = _pageCount;
@synthesize _controllerCache = _controllerCache;

- (void)dealloc
{
    [_scrollView release]; _scrollView = nil;
    [_controllerCache release]; _controllerCache = nil;
    [super dealloc];
}

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initViewComponent
{
    self._scrollView = [[[UIScrollView alloc] init] autorelease];
    self._scrollView.pagingEnabled = YES;
    self._scrollView.showsHorizontalScrollIndicator = NO;
    self._scrollView.showsVerticalScrollIndicator = NO;
    self._scrollView.scrollsToTop = NO;
    self._scrollView.delegate = self;
}

- (void)initModalComponent
{
    self._currentPageIndex = 0;
    self._controllerCache = [[[NSMutableDictionary alloc] init] autorelease];
}

- (void)loadView
{
    [super loadView];
    [self initViewComponent];
    self.view = self._scrollView;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initModalComponent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - private

- (void)loadScrollViewWithPage:(NSInteger)pageIndex
{
    if (pageIndex < 0 || self._pageCount <= pageIndex)
    {
        return;
    }
    
    NSNumber *pageObj = [NSNumber numberWithInt:pageIndex];
    UIViewController *controller = [self._controllerCache objectForKey:pageObj];
    if (!controller)
    {
        controller = [self controllerWithPage:pageIndex];
        [self._controllerCache setObject:controller forKey:pageObj];
    }
    
    if (!controller.view.superview)
    {
        CGSize scrollSize = self._scrollView.frame.size;
        controller.view.frame = CGRectMake(pageIndex * scrollSize.width, 0, scrollSize.width, scrollSize.height);
    }
}

#pragma mark - for override

-(UIViewController *)controllerWithPage:(NSInteger)pageIndex
{
    [NSException raise:NSInternalInconsistencyException format:@"you must override %@ in subclass", NSStringFromSelector(_cmd)];
    return nil;
}

#pragma mark - UIScrollViewDelegate


@end
