//
//  LauncherBadgeView.m
//  LauncherView
//
//  Created by Huang YiFeng on 8/2/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "LauncherBadgeView.h"

static CGFloat const k_default_corner_radius = 7;
static CGFloat const k_default_view_height = 15;

@interface LauncherBadgeView ()

- (void)initComponent;
- (void)setSelfValue:(NSUInteger)value;
- (void)adjustWidth;

@end


@implementation LauncherBadgeView

@synthesize hideWhenZero = _hideWhenZero;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self initComponent];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initComponent];
    }
    return self;
}

#pragma mark - private

- (void)initComponent
{
    self.layer.cornerRadius = k_default_corner_radius;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.textColor = [UIColor whiteColor];
    self.textAlignment = UITextAlignmentCenter;
    self.hidden = YES;
    [self adjustWidth];
}

- (void)adjustWidth
{
    CGSize labelWidth = [self.text sizeWithFont:self.font];
    
    CGRect frame = self.frame;
    frame.size = CGSizeMake(labelWidth.width + k_default_corner_radius + 1, 15);
    self.frame = frame;
}

- (void)setSelfValue:(NSUInteger)value
{
    NSString *labelString = nil;
    if ( 99 < value) 
    {
        labelString = @"99+";
    }
    else
    {
        labelString = [NSString stringWithFormat:@"%d",value];
    }
    self.text = labelString; 
}

#pragma mark - public 

- (void)setBadgeValue:(NSUInteger)badgeValue
{
    if (_badgeValue != badgeValue)
    {
        _badgeValue = badgeValue;
        if (0 == badgeValue && self.hideWhenZero) 
        {
            self.hidden = YES;
        }
        else
        {
            [self setSelfValue:badgeValue];
            [self adjustWidth];
            self.hidden = NO;
        }
    }
}

- (NSUInteger)badgeValue
{
    return _badgeValue;
}

@end
