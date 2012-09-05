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
- (void)refreshScrollViewSize;

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
    self._scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
    [self.view addSubview:self._scrollView];
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
    
    [self loadScrollViewWithPage:self._currentPageIndex - 1];
    [self loadScrollViewWithPage:self._currentPageIndex];
    [self loadScrollViewWithPage:self._currentPageIndex + 1];
    
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

- (void)refreshScrollViewSize
{
    self._pageCount = [self getTotalPageCount];
    CGSize scrollSize = self._scrollView.frame.size;
    [self._scrollView setContentSize:CGSizeMake(scrollSize.width * self._pageCount, scrollSize.height)];
}

#pragma mark - for override

-(UIViewController *)controllerWithPage:(NSInteger)pageIndex
{
    [NSException raise:NSInternalInconsistencyException format:@"you must override %@ in subclass", NSStringFromSelector(_cmd)];
    return nil;
}

- (NSInteger)getTotalPageCount
{
    [NSException raise:NSInternalInconsistencyException format:@"you must override %@ in subclass", NSStringFromSelector(_cmd)];
    return 0;
}

#pragma mark - UIScrollViewDelegate


@end
