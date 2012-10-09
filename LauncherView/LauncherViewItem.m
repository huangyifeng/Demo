//
//  LauncherViewItem.m
//  Gemini
//
//  Created by Huang YiFeng on 6/26/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "LauncherViewItem.h"
#import "NSSafelyRelease.h"

@implementation LauncherViewItem

@synthesize moudleID        = _moudleID;
@synthesize moudleName      = _moudleName;
@synthesize applicationType = _applicationType;
@synthesize isNewApi = _isNewApi;
@synthesize isCybozuBrowserType = _isCybozuBrowserType;
@synthesize linkURL     = _linkURL;
@synthesize iconsInfo   = _iconsInfo;
@synthesize canDelete   = _canDelete;
@synthesize badgeValue  = _badgeValue;
@synthesize badgeNumber = _badgeNumber;

- (void)dealloc
{
    RELEASE_SAFELY(_moudleID);
    RELEASE_SAFELY(_moudleName);
    RELEASE_SAFELY(_linkURL);
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

- (UIImage *)getImageInformation:(ApplicationIconType)appIconType
{
    for (ApplicationIconInformation *iconInfo in self.iconsInfo) 
    {
        if (iconInfo.applicationIconType == appIconType) 
        {
            NSString *imagePath = [ImageManager getImageFileDirPath:iconInfo.iconName];
            if ([ImageManager isFileExists:imagePath]) 
            {
                NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
                return [UIImage imageWithData:imageData];
            }
            break;
        }
    }

    return [UIImage getImageByType:self.applicationType appIconType:appIconType];
}

@end
