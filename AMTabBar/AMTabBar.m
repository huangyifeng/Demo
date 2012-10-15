//
//  AMTabBar.m
//  Demo
//
//  Created by HuangYiFeng on 10/15/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import "AMTabBar.h"

@interface AMTabBar ()

@property(nonatomic, retain)NSArray *_buttons;

@end

@implementation AMTabBar

@synthesize titles      = _titles;
@synthesize delegate    = _delegate;
@synthesize _buttons    = _buttons;

- (void)dealloc
{
    [_titles release]; _titles = nil;
    [_buttons release]; _buttons = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)renderWithTitles:(NSArray *)titles
{
    self.titles = titles;
    
    if (self._buttons)
    {
        [self._buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }
    [self.titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = obj;
        [self addSubview:button];
    }];
    
}

#pragma mark - override

- (void)layoutSubviews
{
    
}


@end
