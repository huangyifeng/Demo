//
//  LauncherView.m
//  LauncherView
//
//  Created by Huang YiFeng on 6/21/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "LauncherView.h"
#import "LauncherViewButton.h"
#import "NSSafelyRelease.h"
#import "LauncherViewDefines.h"
#import "UIImage+RetinaDisplay.h"


static NSInteger const k_default_column_number  = 4;
static NSInteger const k_default_row_number     = 4;
static CGFloat   const k_default_horizental_gap = 10;
static CGFloat   const k_default_vertical_gap   = 10;
static CGFloat   const k_default_top_padding    = 10;
static CGFloat   const k_default_left_padding   = 15;
static CGFloat   const k_default_right_padding  = 15;
static CGFloat   const k_default_bottom_padding = 0;
static CGFloat   const k_default_page_control_height = 26;
static CGFloat   const k_default_wobble_angle = 2;
static CGFloat   const k_default_wobble_interval = 0.1;
static CGFloat   const k_default_spring_load_distance = 45;
static CGFloat   const k_default_spring_load_interval = 0.5;
static CGFloat   const k_default_spring_interval = 0.3;
static NSInteger const k_default_max_page_count = 10;
static CGFloat   const k_default_layout_buttons_duration = 0.2;

@interface LauncherView ()

//View
@property(nonatomic, retain) LauncherScrollView *_scrollView;
@property(nonatomic, retain) UIPageControl      *_pageControl;
@property(nonatomic, retain) UIButton           *_leftButton;
@property(nonatomic, retain) UIButton           *_rightButton;
@property(nonatomic, retain) LauncherViewButton *_draggingButton;

//Model
@property(nonatomic, assign) BOOL            isDragging;
@property(nonatomic, retain) NSTimer        *_springLoadTimer;

@property(nonatomic, assign) NSInteger       pageCount;
@property(nonatomic, assign) NSUInteger      currentPageIndex;
@property(nonatomic, retain) NSMutableArray *buttons;
@property(nonatomic, retain) NSMutableDictionary    *_overflowButtonsDict;

//view
- (void)initSubview;
- (void)loadLayoutParam;
- (void)refreshPageCount;
//- (NSInteger)currentPageIndex;
- (void)createButtons;
- (void)layoutButtons:(BOOL)animated;
- (void)__layoutButtons;
- (void)refreshTurnPageButtonState:(NSInteger)pageIndex;
- (void)startWobble;
- (void)stopWobble;
- (void)updateLayoutDuringPan:(LauncherViewButton *)draggingBtn;

//action
- (void)handleLauncherButtonTouchUpInside:(LauncherViewButton *)button;
- (void)handleLauncherButtonTouchUpOutside:(LauncherViewButton *)button;
- (void)handleLauncherButtonTouchDown:(LauncherViewButton *)button withEvent:(UIEvent *)event;
- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress;
//- (void)handlePan:(UIPanGestureRecognizer *)pan;
- (void)handleLeftButton;
- (void)handleRightButton;
- (void)scrollToPage:(NSInteger)pageIndex animated:(BOOL)animated;
- (void)startDragging:(LauncherViewButton *)button;
- (void)stopDragging;
- (void)loadSpring:(NSTimer *)timer;
- (void)checkButtonOverflow:(NSInteger)pageIndex;
- (void)addNewEmptyPageAtLast;
- (void)removeEmptyButtonPage;

@end

@implementation LauncherView

//UI
@synthesize _scrollView     = _scrollView;
@synthesize _pageControl    = _pageControl;
@synthesize _leftButton     = _leftButton;
@synthesize _rightButton    = _rightButton;
@synthesize buttonSize      = _buttonSize;
@synthesize _draggingButton = _draggingButton;

//model
@synthesize delegate         = _delegate;
@synthesize dataSource       = _dataSource;
@synthesize isEditing        = _isEditing;
@synthesize isDragging       = _isDragging;
@synthesize _springLoadTimer = _springLoadTimer;

@synthesize pageCount        = _pageCount;
@synthesize currentPageIndex = _currentPageIndex;
@synthesize buttons          = _buttons;
@synthesize _overflowButtonsDict    = _overflowButtonsDict;

- (void)dealloc
{
    RELEASE_SAFELY(_scrollView);
    RELEASE_SAFELY(_pageControl);
    RELEASE_SAFELY(_leftButton);
    RELEASE_SAFELY(_rightButton);
    RELEASE_SAFELY(_draggingButton);
    
    RELEASE_SAFELY(_springLoadTimer);
    RELEASE_SAFELY(_overflowButtonsDict);
    RELEASE_SAFELY(_buttons);
    [super dealloc];
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initSubview];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initSubview];
    }
    
    return self;
}

#pragma mark - override

- (void)layoutSubviews
{
    self._scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - k_default_page_control_height);
    
    CGRect pageControlFrame = CGRectMake(0, self.frame.size.height - k_default_page_control_height, self.frame.size.width, k_default_page_control_height);
    self._pageControl.frame = pageControlFrame;
    
    CGSize turnPageButtonSize = CGSizeMake(20, 90);
    self._leftButton.frame = CGRectMake(10, self.buttonSize.height - 30, turnPageButtonSize.width, turnPageButtonSize.height);
    self._rightButton.frame = CGRectMake(self.frame.size.width - turnPageButtonSize.width - 10, self.buttonSize.height - 30, turnPageButtonSize.width, turnPageButtonSize.height);
    [self refreshPageCount];
}

#pragma mark - public

- (void)reloadData
{
    if (self.isEditing)
    {
        [self stopEditing];
    }
    [self setNeedsLayout];
    
    [self loadLayoutParam];
    [self refreshPageCount];
    [self createButtons];
    [self layoutButtons:NO];
    [self refreshTurnPageButtonState:self.currentPageIndex];
    self.userInteractionEnabled = YES;
}

- (void)scrollToNextPage:(BOOL)animated
{
    [self scrollToPage:(self.currentPageIndex + 1) animated:animated];
}

- (void)scrollToPreviousPage:(BOOL)animated
{
    [self scrollToPage:(self.currentPageIndex - 1) animated:animated];
}

- (LauncherViewButton *)buttonAtPosition:(NSIndexPath *)position
{
    LauncherViewButton *button = nil;
    
    if (-1 < position.section && position.section < self.buttons.count)
    {
        NSArray *arr = [self.buttons objectAtIndex:position.section];
        if (-1 < position.row && position.row < arr.count)
        {
            button = [[self.buttons objectAtIndex:position.section] objectAtIndex:position.row];
        }
    }
    
    return button;
}

- (NSIndexPath *)positionForButton:(LauncherViewButton *)button
{
    NSIndexPath *position = nil;
    for (int page = 0, pageCount = self.buttons.count; page < pageCount; page++ ) 
    {
        if ([[self.buttons objectAtIndex:page] containsObject:button]) 
        {
            int index = [[self.buttons objectAtIndex:page] indexOfObject:button];
            position = [NSIndexPath indexPathForRow:index inSection:page];
            break;
        }
    }
    return position;
}

- (void)beginEditing
{
    if (self.isEditing) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(willBeginEditingInLauncherView:)])
    {
        [self.delegate willBeginEditingInLauncherView:self];
    }
    
    self.isEditing = YES;
    self._scrollView.delaysContentTouches = YES;
    for (NSMutableArray *page in self.buttons)
    {
        for (LauncherViewButton *button in page)
        {
            [button setEditing:YES];
        }
    }
    [self addNewEmptyPageAtLast];
    [self refreshPageCount];
    [self startWobble];
    [self refreshTurnPageButtonState:self.currentPageIndex];
    
    if ([self.delegate respondsToSelector:@selector(didBeginEditingInLauncherView:)])
    {
        [self.delegate didBeginEditingInLauncherView:self];
    }
}

- (void)stopEditing
{
    if (!self.isEditing)
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(willEndEditingInLauncherView:)])
    {
        [self.delegate willEndEditingInLauncherView:self];
    }
    
    if (self.isDragging)
    {
        [self stopDragging];
    }
    
    self.isEditing = NO;
    self._scrollView.delaysContentTouches = NO;
    for (NSMutableArray *page in self.buttons)
    {
        for (LauncherViewButton *button in page)
        {
            [button setEditing:NO];
        }
    }
    [self stopWobble];
    [self removeEmptyButtonPage];
    [self refreshPageCount];
    [self layoutButtons:NO];
    [self refreshTurnPageButtonState:self.currentPageIndex];
    
    if ([self.delegate respondsToSelector:@selector(didEndEditingInLauncherView:)])
    {
        [self.delegate didEndEditingInLauncherView:self];
    }
}

- (UIView *)scrollView
{
    return self._scrollView;
}

#pragma mark - private - view

- (void)initSubview
{
    self.backgroundColor = [UIColor clearColor];
    
    self._scrollView = [[[LauncherScrollView alloc] init] autorelease];
    self._scrollView.pagingEnabled = YES;
    self._scrollView.showsHorizontalScrollIndicator = NO;
    self._scrollView.showsVerticalScrollIndicator = NO;
    self._scrollView.alwaysBounceVertical = NO;
    self._scrollView.alwaysBounceHorizontal = YES;
    self._scrollView.scrollsToTop = NO;
    self._scrollView.multipleTouchEnabled = NO;
    self._scrollView.delaysContentTouches = NO;
    self._scrollView.delegate = self;
    self._scrollView.clipsToBounds = NO;
    //    self._scrollView.backgroundColor = [UIColor clearColor];
    
    self._pageControl = [[[UIPageControl alloc] init] autorelease];
    self._pageControl.hidesForSinglePage = NO;
    self._pageControl.backgroundColor = [UIColor clearColor];
    self._pageControl.userInteractionEnabled = NO;
    
    self._leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self._leftButton setImage:[UIImage imageForRetina:@"home_page_left_20_30" ofType:@"png"] forState:UIControlStateNormal];
    self._leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self._leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self._leftButton addTarget:self action:@selector(handleLeftButton) forControlEvents:UIControlEventTouchUpInside];
    
    self._rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self._rightButton setImage:[UIImage imageForRetina:@"home_page_right_20_30" ofType:@"png"] forState:UIControlStateNormal];
    self._rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self._rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self._rightButton addTarget:self action:@selector(handleRightButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self._scrollView];
    [self addSubview:self._pageControl];
    [self addSubview:self._leftButton];
    [self addSubview:self._rightButton];
}

- (void)loadLayoutParam
{
    _columnCount = k_default_column_number;
    _rowCount = k_default_row_number;
    _hGap = k_default_horizental_gap;
    _vGap = k_default_vertical_gap;
    _inset = UIEdgeInsetsMake(k_default_top_padding, k_default_left_padding, k_default_bottom_padding, k_default_left_padding);
    
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnInPerPageInLauncherView:)])
    {
        _columnCount = [self.dataSource numberOfColumnInPerPageInLauncherView:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(numberOfRowInPerPageInLauncherView:)])
    {
        _rowCount = [self.dataSource numberOfRowInPerPageInLauncherView:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(horizentalGapInLauncherView:)]) 
    {
        _hGap = [self.dataSource horizentalGapInLauncherView:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(verticalGapInLauncherView:)]) 
    {
        _vGap = [self.dataSource verticalGapInLauncherView:self];
    }
    
    if ([self.dataSource respondsToSelector:@selector(edgeInsetsInLauncherView:)])
    {
        _inset = [self.dataSource edgeInsetsInLauncherView:self];
    }
}

- (void)refreshPageCount
{
    if (self.isEditing)
    {
        self.pageCount = self.buttons.count;
    }
    else
    {
        if (self.dataSource) 
        {
            self.pageCount = [self.dataSource numberOfPageInLauncherView:self];
        }        
    }
    if (!(self.currentPageIndex < self.pageCount && 0 < self.currentPageIndex))
    {
        self.currentPageIndex = 0;
    }
    self._pageControl.numberOfPages = self.pageCount;
    self._scrollView.contentSize = CGSizeMake(self._scrollView.frame.size.width * self.pageCount, self._scrollView.frame.size.height);
}
//
//- (NSInteger)currentPageIndex
//{
//    return floor(self._scrollView.contentOffset.x / self._scrollView.frame.size.width); 
//}

- (void)createButtons
{
    NSAssert(nil != self.dataSource, @"LaunherView DataSource cannot be nil");
    
    if (self.buttons)
    {
        for (NSMutableArray *pageButtons in self.buttons)
        {
            for (LauncherViewButton *button in pageButtons)
            {
                [button removeFromSuperview];
            }
        }
    }
    
    self.buttons = [NSMutableArray arrayWithCapacity:self.pageCount];
    for (int page = 0; page < self.pageCount; page++)
    {
        int buttonCount = [self.dataSource launcherView:self numberOfButtonsInPage:page];
        NSMutableArray *pageButtons = [NSMutableArray arrayWithCapacity:buttonCount];
        for (int index = 0; index < buttonCount; index++)
        {
            NSIndexPath *position = [NSIndexPath indexPathForRow:index inSection:page];
            LauncherViewButton *button = [self.dataSource launcherView:self buttonAtPosition:position];
            
            [button addTarget:self action:@selector(handleLauncherButtonTouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(handleLauncherButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(handleLauncherButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
            button.delegate = self;
            
            [pageButtons addObject:button];
            [self._scrollView addSubview:button];
        }
        [self.buttons addObject:pageButtons];
    }
}

- (void)layoutButtons:(BOOL)animated
{
    if (animated)
    {
        [UIView animateWithDuration:k_default_layout_buttons_duration animations:^{
            [self __layoutButtons];
        }];
    }
    else
    {
        [self __layoutButtons];
    }
}

- (void)__layoutButtons
{    
    CGRect actualRect = UIEdgeInsetsInsetRect(self._scrollView.frame, _inset);
    for (int page = 0, pageCount = self.buttons.count; page < pageCount; page++)
    {
        NSArray *pageButtons = [self.buttons objectAtIndex:page];
        NSAssert(!(pageButtons.count > (_columnCount * _rowCount)) , @"page button count beyond limit in Page: %d, count: %d",page,pageButtons.count);
        for (int index = 0,buttonCount = pageButtons.count; index < buttonCount; index++) 
        {
            LauncherViewButton *button = [pageButtons objectAtIndex:index];
            if (!button.dragging) 
            {
                CGFloat x = self.frame.size.width * page + actualRect.origin.x + (self.buttonSize.width + _hGap) * (index % _columnCount);
                CGFloat y = actualRect.origin.y + (self.buttonSize.height + _vGap) * floor(index / _columnCount);
                button.frame = CGRectMake(x, y, self.buttonSize.width, self.buttonSize.height);
                button.bounds = CGRectMake(0, 0, self.buttonSize.width, self.buttonSize.height);                
            }
        }
    }
}

- (void)refreshTurnPageButtonState:(NSInteger)pageIndex
{
    if (self.isEditing)
    {
        self._leftButton.hidden = YES;
        self._rightButton.hidden = YES;
    }
    else
    {
        self._leftButton.hidden = NO;
        self._rightButton.hidden = NO;
        if (0 == pageIndex) 
        {
            self._leftButton.hidden = YES;
        }
        if (self.pageCount - 1 == pageIndex || 0 == self.pageCount) 
        {
            self._rightButton.hidden = YES;
        }
        
    }
}

- (void)startWobble
{
    CGFloat wobbleRadians = k_default_wobble_angle * M_PI / 180;
    
    for (NSMutableArray *page in self.buttons)
    {
        CGFloat tempRandians = wobbleRadians;
        for (LauncherViewButton *button in page) 
        {
            tempRandians = -tempRandians;
            button.transform = CGAffineTransformMakeRotation(tempRandians);
        }
    }
    
    UIViewAnimationOptions options = UIViewAnimationOptionRepeat | 
    UIViewAnimationOptionAutoreverse | 
    UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:k_default_wobble_interval delay:0 options:options animations:^{
        for (NSMutableArray *page in self.buttons)
        {     
            CGFloat tempRandians = -wobbleRadians;
            for (LauncherViewButton *button in page) 
            {
                tempRandians = -tempRandians;
                button.transform = CGAffineTransformMakeRotation(tempRandians);;
            }
        }
    } completion:NULL];
}

- (void)stopWobble
{
    [UIView animateWithDuration:0.1 animations:^{
        for (NSMutableArray *page in self.buttons)
        {
            for (LauncherViewButton *button in page) 
            {
                button.transform = CGAffineTransformIdentity;
            }
        }    
    }];
}

- (void)updateLayoutDuringPan:(LauncherViewButton *)draggingBtn
{
    if (!draggingBtn) 
    {
        return;
    }
    CGRect actualRect = UIEdgeInsetsInsetRect(self._scrollView.frame, _inset);
    
    CGPoint centerPoint = CGPointMake(draggingBtn.center.x + self._scrollView.contentOffset.x,
                                      draggingBtn.center.y + self._scrollView.contentOffset.y);
    NSInteger page = self.currentPageIndex;
    NSInteger row = floor(centerPoint.y / (self.buttonSize.height + _vGap));
    NSInteger column = floor((centerPoint.x - self._scrollView.contentOffset.x - actualRect.origin.x) / (self.buttonSize.width + _hGap));
    NSInteger itemIndex = row * _columnCount + column;
    
    BOOL lastOne = NO;
    int currentPageItemCount = [[self.buttons objectAtIndex:page] count];
    BOOL test = (currentPageItemCount - 1 < itemIndex);
    if (test && itemIndex < _rowCount * _columnCount) 
    {
        itemIndex = [[self.buttons objectAtIndex:page] count];
        lastOne = YES;
    }
    
    NSIndexPath *toPosition = [NSIndexPath indexPathForRow:itemIndex inSection:page];
    
    LauncherViewButton *toButton = [self buttonAtPosition:toPosition];
    CGPoint targetCenter = [toButton convertPoint:centerPoint fromView:self._scrollView];
    
    BOOL enterButton = (toButton && toButton != draggingBtn && [draggingBtn pointInside:targetCenter withEvent:nil]);
    BOOL inPageLast = !toButton && lastOne;
    
    if (enterButton || inPageLast)
    {
        CybozuLog(@"Moved to %@",toPosition);
        NSIndexPath *fromPosition = [self positionForButton:draggingBtn];
        NSMutableArray *fromArray = [self.buttons objectAtIndex:fromPosition.section];
        NSMutableArray *toArray = [self.buttons objectAtIndex:toPosition.section];
        
        [draggingBtn retain];
        [fromArray removeObject:draggingBtn];
        if (inPageLast) 
        {
            [toArray addObject:draggingBtn];
        }
        else
        {
            [toArray insertObject:draggingBtn atIndex:toPosition.row];
        }
        [draggingBtn release];
        NSIndexPath *toPosition = [self positionForButton:draggingBtn];
        
        if ([self.delegate respondsToSelector:@selector(launcherView:moveButtonFromPosition:toPosition:)])
        {
            [self.delegate launcherView:self moveButtonFromPosition:fromPosition toPosition:toPosition];
        }
        
        [self checkButtonOverflow:toPosition.section];
        
        [self layoutButtons:YES];
    }
    
    BOOL goLeft = (centerPoint.x - self._scrollView.contentOffset.x - 0) < k_default_spring_load_distance;
    BOOL goRight = (self._scrollView.contentOffset.x + self._scrollView.frame.size.width - centerPoint.x) < k_default_spring_load_distance;
    if (goLeft || goRight) 
    {
        if (!self._springLoadTimer)
        {
            self._springLoadTimer = [NSTimer scheduledTimerWithTimeInterval:k_default_spring_load_interval target:self selector:@selector(loadSpring:) userInfo:[NSNumber numberWithBool:goLeft] repeats:NO];
        }
    }
    else if (self._springLoadTimer)
    {
        INVALIDATE_TIMER(self._springLoadTimer);
    }
}

#pragma mark - private - action

- (void)handleLauncherButtonTouchDown:(LauncherViewButton *)button withEvent:(UIEvent *)event
{
    if (self.isEditing)
    {
        if (!self._draggingButton)
        {
            _touchOrigin = [[[event touchesForView:button] anyObject] locationInView:self];
            [self startDragging:button];
        }
    }
}

- (void)handleLauncherButtonTouchUpInside:(LauncherViewButton *)button
{
    if (self.isDragging)
    {
        [self stopDragging];
    }
    else
    {
        NSIndexPath *position = [self positionForButton:button];
        if ([self.delegate respondsToSelector:@selector(launcherView:didSelectButtonAtPosition:)])
        {
            [self.delegate launcherView:self didSelectButtonAtPosition:position];
        }
    }
}

- (void)handleLauncherButtonTouchUpOutside:(LauncherViewButton *)button
{
    if (self.isDragging)
    {
        [self stopDragging];
    }
}

//@TODO
- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (UIGestureRecognizerStateBegan == longPress.state)
    {
        if (!self.isEditing) 
        {
            [self beginEditing];
            _touchOrigin = [longPress locationInView:self];
            [self startDragging:(LauncherViewButton *)longPress.view];
        }
    }
    else if(UIGestureRecognizerStateEnded == longPress.state)
    {
        if (self.isDragging) 
        {
            [self stopDragging];
        }
    }
}

- (void)handleLeftButton
{
    [self scrollToPreviousPage:YES];
    self.userInteractionEnabled = NO;
}

- (void)handleRightButton
{
    [self scrollToNextPage:YES];
    self.userInteractionEnabled = NO;
}

- (void)scrollToPage:(NSInteger)pageIndex animated:(BOOL)animated
{
    if (!(pageIndex < 0 || self.pageCount - 1 < pageIndex))
    {
        CGSize scrollSize = self._scrollView.frame.size;
        [self._scrollView setContentOffset:CGPointMake(scrollSize.width * pageIndex, 0) animated:animated];
        
        self._pageControl.currentPage = pageIndex;
        self.currentPageIndex = pageIndex;
    }
}

- (void)startDragging:(LauncherViewButton *)button
{
//    [self._scrollView addSubview:button];
    [UIView animateWithDuration:0.2 animations:^{
        if (self._draggingButton)
        {
            self._draggingButton.dragging = NO;
            self._draggingButton = nil;
        }
        
        if (button) 
        {
            self._draggingButton = button;
            button.dragging = YES;
            self.isDragging = YES;
            
        }
    }];
    
    if (button)
    {
        CGPoint convertPoint = [self._scrollView convertPoint:button.center toView:self];
        button.center = convertPoint;
        [self addSubview:button];
        _buttonOrigin = button.center;
    }
    if (!self._overflowButtonsDict) 
    {
        self._overflowButtonsDict = [NSMutableDictionary dictionary];
    }
}

- (void)stopDragging
{
    INVALIDATE_TIMER(self._springLoadTimer);
    if (!self.isDragging)
    {
        return;
    }
    
    
    CGPoint convertPoint = [self._scrollView convertPoint:self._draggingButton.center fromView:self];
    self._draggingButton.center = convertPoint;
    [self._scrollView addSubview:self._draggingButton];
    
    [UIView animateWithDuration:0.2 animations:^{
        if (self._draggingButton)
        {
            self._draggingButton.dragging = NO;
            self._draggingButton = nil;
            self.isDragging = NO;
        }
    }];
    [self._overflowButtonsDict removeAllObjects];
    if (0 < [[self.buttons lastObject] count]) 
    {
        [self addNewEmptyPageAtLast];
    }
    
    [self refreshPageCount];
    [self layoutButtons:YES];
    [self startWobble];
}

- (void)loadSpring:(NSTimer *)timer
{
    if (!self._draggingButton) 
    {
        return;
    }
    
    BOOL goLeft = [timer.userInfo boolValue];
    if ((0 == self.currentPageIndex && goLeft) || (self.buttons.count - 1 == self.currentPageIndex && !goLeft)) 
    {
        return;
    }
    
    INVALIDATE_TIMER(self._springLoadTimer);
    
    if (0 < [self._overflowButtonsDict count]) 
    {
        [self._overflowButtonsDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            LauncherViewButton *button = (LauncherViewButton *)obj;
            NSNumber *pageIndex = (NSNumber *)key;
            
            NSMutableArray *pageButtons = [self.buttons objectAtIndex:[pageIndex intValue]];
            NSMutableArray *nextPage = [self.buttons objectAtIndex:([pageIndex intValue] + 1)];
            
            NSIndexPath *fromPath = [self positionForButton:button];
            [button retain];
            [nextPage removeObject:button];
            [pageButtons addObject:button];
            [button release];
            NSIndexPath *toPath = [self positionForButton:button];
            
            if ([self.delegate respondsToSelector:@selector(launcherView:moveButtonFromPosition:toPosition:)]) 
            {
                [self.delegate launcherView:self moveButtonFromPosition:fromPath toPosition:toPath];
            }
        }];
        [self._overflowButtonsDict removeAllObjects];
    }
    
    if (goLeft)
    {
        [self scrollToPreviousPage:YES];
    }
    else
    {
        [self scrollToNextPage:YES];
    }
    
    //add dragging button to this page last one
    NSIndexPath *fromPosition = [self positionForButton:self._draggingButton];
    NSInteger toIndex = goLeft? fromPosition.section - 1: fromPosition.section + 1;
    
    [[self.buttons objectAtIndex:fromPosition.section] removeObject:self._draggingButton];
    [[self.buttons objectAtIndex:toIndex] addObject:self._draggingButton];
    NSIndexPath *toPosition = [self positionForButton:self._draggingButton];
    
    if ([self.delegate respondsToSelector:@selector(launcherView:moveButtonFromPosition:toPosition:)]) 
    {
        [self.delegate launcherView:self moveButtonFromPosition:fromPosition toPosition:toPosition];
    }
    
    [self checkButtonOverflow:toIndex];
}

- (void)checkButtonOverflow:(NSInteger)pageIndex
{
    NSMutableArray *pageButtons = [self.buttons objectAtIndex:pageIndex];
    NSInteger maxItemCount = _rowCount * _columnCount;
    if (maxItemCount < pageButtons.count) 
    {
        BOOL isLastPage = pageIndex == self.buttons.count - 1;
        
        if (isLastPage)
        {
            [self addNewEmptyPageAtLast];
        }
        
        LauncherViewButton *lastButton = [pageButtons lastObject];
        NSMutableArray *nextPageButtons = [self.buttons objectAtIndex:pageIndex + 1];
        
        NSIndexPath *fromPath = [self positionForButton:lastButton];
        [lastButton retain];
        [pageButtons removeObject:lastButton];
        [nextPageButtons insertObject:lastButton atIndex:0];
        [lastButton release];
        NSIndexPath *toPath = [self positionForButton:lastButton];
                
        [self._overflowButtonsDict setObject:lastButton forKey:[NSNumber numberWithInt:pageIndex]];
        
        if ([self.delegate respondsToSelector:@selector(launcherView:moveButtonFromPosition:toPosition:)]) 
        {
            [self.delegate launcherView:self moveButtonFromPosition:fromPath toPosition:toPath];
        }
        
        [self checkButtonOverflow:pageIndex + 1];
    }
}

- (void)addNewEmptyPageAtLast
{
    if (self.buttons.count < k_default_max_page_count)
    {
        [self.buttons addObject:[NSMutableArray array]];
        
        if([self.delegate respondsToSelector:@selector(launcherView:addNewPageAtIndex:)])
        {
            [self.delegate launcherView:self addNewPageAtIndex:(self.buttons.count - 1)];
        }
    }
}

- (void)removeEmptyButtonPage
{    
    for (int i = self.buttons.count - 1; i > -1; i--)
    {
        NSMutableArray *pageButtons = [self.buttons objectAtIndex:i];
        if (0 == pageButtons.count)
        {
            [self.buttons removeObjectAtIndex:i];
            if ([self.delegate respondsToSelector:@selector(launcherView:removePageAtIndex:)]) 
            {
                [self.delegate launcherView:self removePageAtIndex:i];
            }
        }
    }
}

#pragma mark - UIResponder

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (self.isEditing)
    {
        if (self.isDragging && self._draggingButton)
        {
            CGPoint touchNow = [[touches anyObject] locationInView:self];
            self._draggingButton.center = CGPointMake(_buttonOrigin.x + (touchNow.x - _touchOrigin.x),
                                                      _buttonOrigin.y + (touchNow.y - _touchOrigin.y));
            [self updateLayoutDuringPan:self._draggingButton];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.isDragging)
    {
        [self stopDragging];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (self.isDragging)
    {
        [self stopDragging];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPageIndex = floor(self._scrollView.contentOffset.x / self._scrollView.frame.size.width); 
    self._pageControl.currentPage = self.currentPageIndex;
    [self refreshTurnPageButtonState:self.currentPageIndex];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.userInteractionEnabled = YES;
    [self refreshTurnPageButtonState:self.currentPageIndex];
}


#pragma mark - LauncherViewButtonDelegate

- (void)launcherViewButton:(LauncherViewButton *)button didLongPress:(UILongPressGestureRecognizer *)longPressGes
{
    [self handleLongPress:longPressGes];
}

- (void)launcherViewButtonDidTapDeleteButton:(LauncherViewButton *)button
{
    NSIndexPath *deletePosition = [self positionForButton:button];
    BOOL shouldDelete = YES;
    if ([self.delegate respondsToSelector:@selector(launcherView:shouldDeleteButtonAtPosition:)])
    {
        shouldDelete = [self.delegate launcherView:self shouldDeleteButtonAtPosition:deletePosition];
    }

    if (shouldDelete)
    {
        [UIView animateWithDuration:k_default_layout_buttons_duration animations:^{
            button.transform = CGAffineTransformMakeScale(0.3, 0.3);
            button.alpha = 0.1;
        } completion:^(BOOL finished) {
            
            NSMutableArray *pageButtons = [self.buttons objectAtIndex:deletePosition.section];
            [pageButtons removeObject:button];
            [button removeFromSuperview];
            [self layoutButtons:YES];
            
            if ([self.delegate respondsToSelector:@selector(launcherView:didDeleteButtonAtPostion:)])
            {
                [self.delegate launcherView:self didDeleteButtonAtPostion:deletePosition];
            }
        }];
    }
}

@end
