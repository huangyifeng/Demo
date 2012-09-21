//
//  ScrollToolbar.m
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollToolbar.h"

@interface ScrollToolbar ()

//View
@property(nonatomic, retain)UIScrollView    *_scrollView;
@property(nonatomic, retain)UIView          *_arrowView;

- (void)initComponent;

@end

@implementation ScrollToolbar

//View
@synthesize _scrollView = _scrollView;
@synthesize _arrowView  = _arrowView;

//Model


- (void)dealloc
{
    [_scrollView release]; _scrollView = nil;
    [_arrowView release];  _arrowView = nil;
    [super dealloc];
}

#pragma mark - initialize

- (void)initComponent
{
    self._scrollView = [[[UIScrollView alloc] init] autorelease];
    self._scrollView.showsHorizontalScrollIndicator = NO;
    self._scrollView.showsVerticalScrollIndicator = NO;
    
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

#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
