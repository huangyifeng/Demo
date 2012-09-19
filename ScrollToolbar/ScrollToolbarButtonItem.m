//
//  ScrollToolbarButtonItem.m
//  Demo
//
//  Created by huang yifeng on 12-9-20.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollToolbarButtonItem.h"

@implementation ScrollToolbarButtonItem

@synthesize title = _title;
@synthesize image = _image;

- (void)dealloc
{
    [_title release]; _title = nil;
    [_image release]; _image = nil;
    [super dealloc];
}

@end
