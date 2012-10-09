//
//  LauncherScrollView.m
//  Gemini
//
//  Created by Huang YiFeng on 7/13/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "LauncherScrollView.h"

@implementation LauncherScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return !self.delaysContentTouches;
}

@end
