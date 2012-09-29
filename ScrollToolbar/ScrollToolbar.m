//
//  ScrollToolbar.m
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollToolbar.h"

static CGFloat k_default_arrow_height = 20;
static CGFloat k_default_button_widht = 80;


@interface ScrollToolbar ()

//View
@property(nonatomic, retain)UIScrollView    *_scrollView;
@property(nonatomic, retain)UIView          *_arrowView;

@property(nonatomic, assign)CGFloat         _buttonWidth;
@property(nonatomic, retain)NSArray         *_buttons;

//view
- (void)initComponent;
- (void)loadLayoutParam;
- (void)createButtons;

//action
- (void)arrowMoveToIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end

@implementation ScrollToolbar

//View
@synthesize _scrollView = _scrollView;
@synthesize _arrowView  = _arrowView;
@synthesize _buttons    = _buttons;

//Model
@synthesize delegate    = _delegate;
@synthesize dataSource  = _dataSource;


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

- (void)arrowMoveToIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    
}

- (void)createButtons
{
    if (self._buttons && 0 < self._buttons.count)
    {
        [self._buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }
}


#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
}

@end
