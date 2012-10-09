//
//  LauncherViewItem.h
//  LauncherView
//
//  Created by Huang YiFeng on 6/26/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationInformation.h"
#import "BaseNSCoding.h"

@interface LauncherViewItem : BaseNSCoding
{
@private
    NSString                    *_moudleID;
    NSString                    *_moudleName;
    NSArray                     *_iconsInfo;
    BOOL                         _canDelete;
    NSString                    *_badgeValue;
    NSInteger                    _badgeNumber;
}

@property(nonatomic, copy)   NSString                *moudleID;
@property(nonatomic, copy)   NSString                *moudleName;
@property(nonatomic, retain) NSArray                 *iconsInfo;
@property(nonatomic, assign) BOOL                     canDelete;
@property(nonatomic, copy)   NSString                *badgeValue;
@property(nonatomic, assign) NSInteger                badgeNumber;

@end
