//
//  LauncherViewDataSource.h
//  LauncherView
//
//  Created by Huang YiFeng on 6/21/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LauncherView, LauncherViewButton;

@protocol LauncherViewDataSource <NSObject>

@optional

// default is 4
- (NSInteger)numberOfColumnInPerPageInLauncherView:(LauncherView *)launcherView;

// default is 4
- (NSInteger)numberOfRowInPerPageInLauncherView:(LauncherView *)launcherView;

// default is 10
- (CGFloat)horizentalGapInLauncherView:(LauncherView *)launcherView;

// default is 10;
- (CGFloat)verticalGapInLauncherView:(LauncherView *)launcherView;

//// default is 10
//- (CGFloat)topPaddingInLauncherView:(LauncherView *)launcherView;
//
//// default is 15
//- (CGFloat)leftPaddingInLauncherView:(LauncherView *)launcherView;

// default is top:10  left:15  right:15  bottom:0;
- (UIEdgeInsets)edgeInsetsInLauncherView:(LauncherView *)launcherView;

//the default value is YES
- (BOOL)canDeleteButtonAtPosition:(NSIndexPath *)position;


@required

- (NSInteger)numberOfPageInLauncherView:(LauncherView *)launcherView;

- (NSInteger)launcherView:(LauncherView *)launcherView numberOfButtonsInPage:(NSInteger)page;

//indexPath.section -> page
//indexPath.row  -> index
- (LauncherViewButton *)launcherView:(LauncherView *)launcher 
                    buttonAtPosition:(NSIndexPath *)position;

@end
