//
//  LauncherViewItem.m
//  LauncherView
//
//  Created by Huang YiFeng on 6/26/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "LauncherViewItem.h"
#import "NSSafelyRelease.h"

@implementation LauncherViewItem

@synthesize moudleID        = _moudleID;
@synthesize moudleName      = _moudleName;
@synthesize iconsInfo   = _iconsInfo;
@synthesize canDelete   = _canDelete;
@synthesize badgeValue  = _badgeValue;
@synthesize badgeNumber = _badgeNumber;

- (void)dealloc
{
    RELEASE_SAFELY(_moudleID);
    RELEASE_SAFELY(_moudleName);
    RELEASE_SAFELY(_iconsInfo);
    RELEASE_SAFELY(_badgeValue);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _badgeNumber = 0;
    }
    
    return self;
}

@end
