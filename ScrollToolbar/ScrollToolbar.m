//
//  ScrollToolbar.m
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollToolbar.h"

@interface ScrollToolbar ()

@property(nonatomic, retain)UIScrollView    *_scrollView;
@property(nonatomic, retain)UIView          *_arrowView;

@end

@implementation ScrollToolbar

- (void)dealloc
{
    [_scrollView release]; _scrollView = nil;
    [_arrowView release];  _arrowView = nil;
    [super dealloc];
}

#pragma mark - initialize

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
