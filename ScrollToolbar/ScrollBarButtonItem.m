//
//  ScrollBarButtonItem.m
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import "ScrollBarButtonItem.h"

@implementation ScrollBarButtonItem

@synthesize title = _title;
@synthesize image = _image;

- (void)dealloc
{
    [_title release]; _title = nil;
    [_image release]; _image = nil;
    [super dealloc];
}

@end
