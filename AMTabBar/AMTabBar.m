//
//  AMTabBar.m
//  Demo
//
//  Created by HuangYiFeng on 10/15/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "AMTabBar.h"

static CGFloat const k_default_dot_width = 10;
static CGFloat const k_default_dot_height = 10;
static CGFloat const k_default_animation_duration = 0.2;


@interface AMTabBar ()

- (void)buttonTapped:(UIButton *)sender;
- (void)moveDotToIndex:(NSInteger)index animated:(BOOL)animated;
- (void)__moveDotToIndex:(NSInteger)index;
- (void)initSelectedDot;

@property(nonatomic, retain)NSArray *_buttons;
@property(nonatomic, retain)UIView  *_selectedDot;


@end

@implementation AMTabBar
    
@synthesize titles      = _titles;
@synthesize delegate    = _delegate;
@synthesize _buttons    = _buttons;

@synthesize selectedIndex   = _selectedIndex;
@synthesize _selectedDot    = _selectedDot;

- (void)dealloc
{
    [_titles release]; _titles = nil;
    [_buttons release]; _buttons = nil;
    [_selectedDot release]; _selectedDot = nil;
    [super dealloc];
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelectedDot];
        _selectedIndex = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initSelectedDot];
        _selectedIndex = 0;
    }
    return self;
}

#pragma mark - override

- (void)layoutSubviews
{
    CGFloat width = self.frame.size.width / self._buttons.count;
    [self._buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        button.frame = CGRectMake(width * idx, 0, width, self.frame.size.height);
    }];
    
    [self bringSubviewToFront:self._selectedDot];
    [self moveDotToIndex:_selectedIndex animated:NO];
}

#pragma mark - private

- (void)initSelectedDot
{
    self._selectedDot = [[[UIView alloc] init] autorelease];
    self._selectedDot.backgroundColor = [UIColor redColor];
    
    [self addSubview:self._selectedDot];
}

- (void)buttonTapped:(UIButton *)sender
{
    self.selectedIndex = [self._buttons indexOfObject:sender];
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [self.delegate tabBar:self didSelectIndex:_selectedIndex];
    }
}

- (void)moveDotToIndex:(NSInteger)index animated:(BOOL)animated
{
    if (animated)
    {
        [UIView animateWithDuration:k_default_animation_duration animations:^{
            [self __moveDotToIndex:index];
        }];
    }
    else
    {
        [self __moveDotToIndex:index];
    }
}

- (void)__moveDotToIndex:(NSInteger)index
{
    UIButton *button = [self._buttons objectAtIndex:index];
    CGFloat dotX = button.center.x - k_default_dot_width / 2;
    CGFloat dotY = self.frame.size.height - k_default_dot_height;
    CGRect dotRect = CGRectMake(dotX, dotY, k_default_dot_width, k_default_dot_height);
    self._selectedDot.frame = dotRect;
}

#pragma mark - public 

- (void)renderWithTitles:(NSArray *)titles
{
    self.titles = titles;
    
    if (self._buttons)
    {
        [self._buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }
    
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:self.titles.count];
    [self.titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [buttons addObject:button];
    }];
    self._buttons = buttons;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        [self moveDotToIndex:_selectedIndex animated:YES];
    }
}

@end
