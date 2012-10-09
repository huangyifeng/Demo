//
//  LauncherViewButton.h
//  LauncherView
//
//  Created by Huang YiFeng on 6/21/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LauncherViewButtonDelegate.h"
#import "LauncherBadgeView.h"

@interface LauncherViewButton : UIControl
{
@private
    //UI
    UIButton            *_bodyButton;
    UILabel             *_nameLabel;
    UIButton            *_deleteButton;
    LauncherBadgeView       *_badge;
    UIEdgeInsets         _padding;
    UILongPressGestureRecognizer    *_longPressGes;
//    UIPanGestureRecognizer          *_panGes;
    
    //Model
    BOOL         _canDelete;
    BOOL         _editing;
    BOOL         _dragging;
    NSInteger    _badgeNumber;
    
    id<LauncherViewButtonDelegate>   _delegate;
}

@property(nonatomic, assign)UIImage     *image;
@property(nonatomic, assign)NSString    *title;
@property(nonatomic, assign)UIEdgeInsets padding;
@property(nonatomic, assign)id<LauncherViewButtonDelegate>   delegate;

@property(nonatomic, assign)BOOL         canDelete;
@property(nonatomic, assign)NSInteger    badgeNumber;

@property(nonatomic, assign)BOOL         editing;
@property(nonatomic, assign)BOOL         dragging;

- (id)initWithImage:(UIImage *)image title:(NSString *)title;

@end
