//
//  ScrollToolbar.m
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollToolbar.h"
#import "ScrollToolbarButton.h"

static CGFloat k_default_arrow_height = 20;
static CGFloat k_default_button_widht = 80;
static CGFloat k_default_scroll_duration = 0.3;


@interface ScrollToolbar ()

//View
@property(nonatomic, retain)UIScrollView    *_scrollView;
@property(nonatomic, retain)UIView          *_arrowView;

@property(nonatomic, assign)CGFloat         _buttonWidth;
@property(nonatomic, retain)NSArray         *_buttons;
@property(nonatomic, assign)NSInteger       _numberOfButtons;

//view
- (void)initComponent;
- (void)loadLayoutParam;
- (void)createButtons;

//action
- (void)arrowMoveToIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
- (void)__arrowMoveToIndex:(NSInteger)buttonIndex;

@end

@implementation ScrollToolbar

//View
@synthesize _scrollView = _scrollView;
@synthesize _arrowView  = _arrowView;
@synthesize _buttons    = _buttons;

//Model
@synthesize delegate    = _delegate;
@synthesize dataSource  = _dataSource;
@synthesize _numberOfButtons = _numberOfButtons;


- (void)dealloc
{
    [_scrollView release]; _scrollView = nil;
    [_arrowView release];  _arrowView = nil;
    [_buttons release]; _buttons = nil;
    [super dealloc];
}

#pragma mark - initialize

- (void)initComponent
{
    self._scrollView = [[[UIScrollView alloc] init] autorelease];
    self._scrollView.showsHorizontalScrollIndicator = NO;
    self._scrollView.showsVerticalScrollIndicator = NO;
    self._scrollView.scrollsToTop = NO;
    self._scrollView.multipleTouchEnabled = NO;
    
    self._arrowView = [[[UIView alloc] init] autorelease];
    self._arrowView.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self._scrollView];
    [self addSubview:self._arrowView];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComponent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponent];
    }
    return self;
}

#pragma mark - private

- (void)loadLayoutParam
{
    self._numberOfButtons = 0;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfButtonInToolbar:)])
    {
        self._numberOfButtons = [self.dataSource numberOfButtonInToolbar:self];
    }
}

- (void)arrowMoveToIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (animated)
    {
        [UIView animateWithDuration:k_default_scroll_duration animations:^{
            [self __arrowMoveToIndex:buttonIndex];
        }];
    }
    else
    {
        [self __arrowMoveToIndex:buttonIndex];
    }
}

- (void)__arrowMoveToIndex:(NSInteger)buttonIndex
{
    if (-1 < buttonIndex && buttonIndex < [self._buttons count])
    {
        UIView *button = [self._buttons objectAtIndex:buttonIndex];
        CGPoint buttonPoint = button.frame.origin;
        CGSize  buttonSize = button.frame.size;
        CGRect  arrowFrame = self._arrowView.frame;
        CGFloat dx = (buttonPoint.x + buttonSize.width / 2 - arrowFrame.size.width / 2) - arrowFrame.origin.x;
        self._arrowView.frame = CGRectOffset(arrowFrame, dx, 0);
    }
}

- (void)createButtons
{
    if (self._buttons && 0 < self._buttons.count)
    {
        [self._buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }

    if ([self.dataSource respondsToSelector:@selector(toolbar:buttonAtPosition:)])
    {
        NSMutableArray *buttons = [NSMutableArray array];
        for (int i = 0; i < self._numberOfButtons; i++)
        {
            ScrollToolbarButton *button = [self.dataSource toolbar:self buttonAtPosition:i];
            [self._scrollView addSubview:button];
            [buttons addObject:button];
        }
        self._buttons = buttons;
    }
}


#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self createButtons];
    
    self._scrollView.frame = self.frame;
    
    
    
}

@end
