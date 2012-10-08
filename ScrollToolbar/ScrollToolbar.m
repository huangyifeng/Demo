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
static CGFloat k_default_arrow_width = 20;
static CGFloat k_default_button_width = 64;
static CGFloat k_default_hint_width = 10;
static CGFloat k_default_hint_height = 15;
static CGFloat k_default_scroll_duration = 0.3;


@interface ScrollToolbar ()

//View
@property(nonatomic, retain)UIScrollView    *_scrollView;
@property(nonatomic, retain)UIView          *_bkView;
@property(nonatomic, retain)UIView          *_arrowView;
@property(nonatomic, retain)UIView          *_leftView;
@property(nonatomic, retain)UIView          *_rightView;

//model
@property(nonatomic, assign)CGFloat          _buttonWidth;
@property(nonatomic, retain)NSArray         *_buttons;
@property(nonatomic, assign)NSInteger        _numberOfButtons;
@property(nonatomic, assign)NSInteger        _selectedButtonIndex;

//view
- (void)initComponent;
- (void)loadLayoutParam;
- (void)createAndLayoutButtons;
- (void)refreshHintView;

//action
- (void)moveArrowToIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
- (void)__moveArrowToIndex:(NSInteger)buttonIndex;
- (void)moveScrollViewToCenter:(NSInteger)buttonIndex animated:(BOOL)animated;
- (void)__moveScrollViewToCenter:(NSInteger)buttonIndex;
- (void)toolbarButtonTapped:(id)sender;

@end

@implementation ScrollToolbar

//View
@synthesize _scrollView = _scrollView;
@synthesize _bkView     = _bkView;
@synthesize _arrowView  = _arrowView;
@synthesize _buttons    = _buttons;
@synthesize _leftView   = _leftView;
@synthesize _rightView  = _rightView;

//Model
@synthesize delegate                = _delegate;
@synthesize dataSource              = _dataSource;
@synthesize _numberOfButtons        = _numberOfButtons;
@synthesize _selectedButtonIndex    = _selectedButtonIndex;


- (void)dealloc
{
    [_scrollView release];  _scrollView = nil;
    [_arrowView release];   _arrowView = nil;
    [_bkView release];      _bkView = nil;
    [_buttons release];     _buttons = nil;
    [_leftView release];    _leftView = nil;
    [_rightView release];   _rightView = nil;
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
    self._scrollView.bounces = YES;
    self._scrollView.delegate = self;
    
    self._bkView = [[[UIView alloc] init] autorelease];
    
    self._arrowView = [[[UIView alloc] init] autorelease];
    
    self._leftView = [[[UIView alloc] init] autorelease];
    self._leftView.backgroundColor = [UIColor redColor];
    self._rightView = [[[UIView alloc] init] autorelease];
    self._rightView.backgroundColor = [UIColor redColor]; 
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self._bkView];
    [self addSubview:self._scrollView];
    [self._scrollView addSubview:self._arrowView];
    [self addSubview:self._leftView];
    [self addSubview:self._rightView];
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

#pragma mark - private view

- (void)loadLayoutParam
{
    self._numberOfButtons = 0;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfButtonInToolbar:)])
    {
        self._numberOfButtons = [self.dataSource numberOfButtonInToolbar:self];
    }
}

- (void)createAndLayoutButtons
{
    if (self._buttons && 0 < self._buttons.count)
    {
        [self._buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }

    CGFloat occupiedWidth = 0;
    if ([self.dataSource respondsToSelector:@selector(toolbar:buttonAtPosition:)])
    {
        NSMutableArray *buttons = [NSMutableArray array];
        for (int i = 0; i < self._numberOfButtons; i++)
        {
            ScrollToolbarButton *button = [self.dataSource toolbar:self buttonAtPosition:i];
            [button addTarget:self action:@selector(toolbarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat buttonWidth = k_default_button_width;
            if([self.delegate respondsToSelector:@selector(toolbar:widthForButtonAtPosition:)])
            {
                buttonWidth = [self.delegate toolbar:self widthForButtonAtPosition:i];
            }
            
            button.frame = CGRectMake(occupiedWidth, k_default_arrow_height, buttonWidth, self._scrollView.frame.size.height - k_default_arrow_height);
            occupiedWidth += buttonWidth;
            
            [self._scrollView addSubview:button];
            [buttons addObject:button];
        }
        self._buttons = buttons;
    }
    [self._scrollView setContentSize:CGSizeMake(occupiedWidth, self.frame.size.height)];
}

- (void)refreshHintView
{
    self._leftView.hidden = !(0 < self._scrollView.contentOffset.x);
    self._rightView.hidden = !(self._scrollView.contentSize.width > self._scrollView.contentOffset.x + self.frame.size.width);
}

#pragma mark - private aciton

- (void)moveArrowToIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if(animated)
    {
        [UIView animateWithDuration:k_default_scroll_duration animations:^{
            [self __moveArrowToIndex:buttonIndex];
        }];
    }
    else
    {
        [self __moveArrowToIndex:buttonIndex];
    }
}

- (void)__moveArrowToIndex:(NSInteger)buttonIndex
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

- (void)moveScrollViewToCenter:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if(animated)
    {
        [UIView animateWithDuration:k_default_scroll_duration animations:^{
            [self __moveScrollViewToCenter:buttonIndex];
        }];
    }
    else
    {
        [self __moveScrollViewToCenter:buttonIndex];
    }
}

- (void)__moveScrollViewToCenter:(NSInteger)buttonIndex
{
    CGFloat minValue = 0;
    CGFloat maxValue = self._scrollView.contentSize.width - self._scrollView.frame.size.width;
    
    ScrollToolbarButton *button = [self._buttons objectAtIndex:buttonIndex];
    CGFloat left = (self._scrollView.frame.size.width - button.frame.size.width) / 2;
    CGFloat x = MIN(maxValue, MAX(button.frame.origin.x - left, minValue));
    [self._scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
}

- (void)toolbarButtonTapped:(id)sender
{
    NSInteger buttonIndex = [self._buttons indexOfObject:sender];
    [self moveArrowToIndex:buttonIndex animated:YES];
    [self moveScrollViewToCenter:buttonIndex animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(toolbar:didTapButtonAtPosition:)])
    {
        [self.delegate toolbar:self didTapButtonAtPosition:buttonIndex];
    }
}

#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self loadLayoutParam];

    CGSize frameSize = self.frame.size;
    
    //layout scroll view
    self._scrollView.frame = CGRectMake(0, 0, frameSize.width, frameSize.height);
    
    //layout button
    [self createAndLayoutButtons];
    
    //layout background view;
    self._bkView.frame = CGRectMake(0, k_default_arrow_height, frameSize.width, frameSize.height - k_default_arrow_height);
    
    //layout arrow view
    self._arrowView.frame = CGRectMake(0, 0, k_default_arrow_width, k_default_arrow_height);
    [self moveArrowToIndex:self._selectedButtonIndex animated:NO];
    
    //layout left and right view
    CGFloat y = (self._bkView.frame.size.height - k_default_hint_height) / 2 + self._bkView.frame.origin.y;
    self._leftView.frame = CGRectMake(5, y, k_default_hint_width, k_default_hint_height);
    self._rightView.frame = CGRectMake(frameSize.width - k_default_hint_width - 5, y, k_default_hint_width, k_default_hint_height);
    
    [self refreshHintView];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    [self._scrollView setBackgroundColor:[UIColor clearColor]];
    [self._bkView setBackgroundColor:backgroundColor];
    [self._arrowView setBackgroundColor:backgroundColor];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshHintView];
}


@end
