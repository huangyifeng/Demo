//
//  LauncherView.h
//  Gemini
//
//  Created by Huang YiFeng on 6/21/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LauncherViewDataSource.h"
#import "LauncherViewDelegate.h"
#import "LauncherScrollView.h"
#import "LauncherViewButtonDelegate.h"

@interface LauncherView : UIView <UIScrollViewDelegate, LauncherViewButtonDelegate>
{
    //View
    LauncherScrollView          *_scrollView;
    UIPageControl               *_pageControl;
    UIButton                    *_leftButton;
    UIButton                    *_rightButton;
    CGSize                       _buttonSize;

    NSInteger                    _columnCount;
    NSInteger                    _rowCount;
    CGFloat                      _hGap;
    CGFloat                      _vGap;
    UIEdgeInsets                 _inset;
    
    CGPoint                      _touchOrigin;
    CGPoint                      _buttonOrigin;
    
    //Model
    id<LauncherViewDelegate>     _delegate;
    id<LauncherViewDataSource>   _dataSource;
    BOOL                         _isEditing;
    BOOL                         _isDragging;
    NSInteger                    _pageCount;
    NSUInteger                   _currentPageIndex;
    LauncherViewButton          *_draggingButton;
    NSTimer                     *_springLoadTimer;
    NSMutableDictionary         *_overflowButtonsDict;
    
    NSMutableArray              *_buttons;//<NSArray <NSArray <Button>>>
}

@property(nonatomic, assign) CGSize                     buttonSize;

@property(nonatomic, assign) IBOutlet id<LauncherViewDelegate>   delegate;
@property(nonatomic, assign) IBOutlet id<LauncherViewDataSource> dataSource;
@property(nonatomic, assign) BOOL            isEditing;

- (void)reloadData;
- (void)scrollToNextPage:(BOOL)animated;
- (void)scrollToPreviousPage:(BOOL)animated;
- (LauncherViewButton *)buttonAtPosition:(NSIndexPath *)position;
- (NSIndexPath *)positionForButton:(LauncherViewButton *)button;
- (void)beginEditing;
- (void)stopEditing;
- (UIView *)scrollView;

@end
