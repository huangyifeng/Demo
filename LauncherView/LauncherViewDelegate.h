//
//  LauncherViewDelegate.h
//  Gemini
//
//  Created by Huang YiFeng on 6/21/12.
//  Copyright (c) 2012 Cybozu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LauncherView, LauncherViewButton;

@protocol LauncherViewDelegate <NSObject>

@optional

- (void)willBeginEditingInLauncherView:(LauncherView *)launcherView;
- (void)willEndEditingInLauncherView:(LauncherView *)launcherView;

- (void)didBeginEditingInLauncherView:(LauncherView *)launcherView;
- (void)didEndEditingInLauncherView:(LauncherView *)launcherView;

- (void)launcherView:(LauncherView *)launcherView
moveButtonFromPosition:(NSIndexPath *)from
          toPosition:(NSIndexPath *)to;

//default is YES
- (BOOL)launcherView:(LauncherView *)launcherView
        shouldDeleteButtonAtPosition:(NSIndexPath *)position;

- (void)launcherView:(LauncherView *)launcherView 
     didDeleteButtonAtPostion:(NSIndexPath *)position;

//indexPath.section -> page
//indexPath.row  -> index
- (void)launcherView:(LauncherView *)launcherView 
     didSelectButtonAtPosition:(NSIndexPath *)position;

- (void)launcherView:(LauncherView *)launcherView
   didScrollFromPage:(NSInteger)from
              toPage:(NSInteger)to;

- (void)launcherView:(LauncherView *)launcherView
   addNewPageAtIndex:(NSInteger)pageIndex;

- (void)launcherView:(LauncherView *)launcherView
   removePageAtIndex:(NSInteger)pageIndex;

@end
