//
//  ScrollToolbarButton.m
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollToolbarButton.h"

@interface ScrollToolbarButton ()

@property(nonatomic, retain)UILabel     *_buttonNameLabel;
@property(nonatomic, retain)UIImageView *_buttonImageView;

- (void)initViewComponent;

@end

@implementation ScrollToolbarButton

@synthesize toolbarItem = _toolbarItem;
@synthesize _buttonNameLabel = _buttonNameLabel;
@synthesize _buttonImageView = _buttonImageView;

- (void)dealloc
{
    [_toolbarItem release]; _toolbarItem = nil;
    [_buttonNameLabel release]; _buttonNameLabel = nil;
    [_buttonImageView release]; _buttonImageView = nil;
    [super dealloc];
}

#pragma mark - init

- (void)initViewComponent
{
    self.backgroundColor = [UIColor clearColor];
    
    self._buttonNameLabel = [[[UILabel alloc] init] autorelease];
    self._buttonNameLabel.textAlignment = UITextAlignmentCenter;
    self._buttonNameLabel.textColor = [UIColor blackColor];
//    self._buttonNameLabel.backgroundColor = [UIColor clearColor];
    
    self._buttonImageView = [[[UIImageView alloc] init] autorelease];
    
    [self addSubview:self._buttonNameLabel];
    [self addSubview:self._buttonImageView];
}

- (id)initWithToolbarItem:(ScrollToolbarButtonItem *)toolbarItem
{
    self = [super init];
    if (self)
    {
        self.toolbarItem = toolbarItem;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initViewComponent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewComponent];
    }
    return self;
}

#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._buttonNameLabel.text = self.toolbarItem.title;
    self._buttonImageView.image = [UIImage imageNamed:self.toolbarItem.image];
    
    self._buttonNameLabel.frame = CGRectMake(7, 10, 50, 20);
}

@end
