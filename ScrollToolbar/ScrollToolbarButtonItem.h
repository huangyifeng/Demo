//
//  ScrollToolbarButtonItem.h
//  Demo
//
//  Created by huang yifeng on 12-9-20.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollToolbarButtonItem : NSObject
{
    NSString    *_title;
    NSString    *_image;
}

@property(nonatomic, retain)NSString    *title;
@property(nonatomic, retain)NSString    *image;

@end