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

- (void)dealloc
{
    [_buttonNameLabel release]; _buttonNameLabel = nil;
    [_buttonImageView release]; _buttonImageView = nil;
    [super dealloc];
}



#pragma mark - init

- (void)initViewComponent
{
    self._buttonNameLabel = [[[UILabel alloc] init] autorelease];
    self._buttonNameLabel.textAlignment = UITextAlignmentCenter;
    self._buttonNameLabel.textColor = [UIColor blackColor];
    
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
    
}

@end
