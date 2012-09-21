//
//  ScrollToolbarDelegate.h
//  Demo
//
//  Created by huang yifeng on 12-9-20.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScrollToolbar, ScrollToolbarButton;


@protocol ScrollToolbarDataSource <NSObject>

- (NSInteger)numberOfButtonInToolbar:(ScrollToolbar *)toolbar;
- (ScrollToolbarButton *)toolbar:(ScrollToolbar *)toolbar buttonAtPosition:(NSInteger)position;

@end

@protocol ScrollToolbarDelegate <NSObject>

- (void)toolbar:(ScrollToolbar *)toolbar didTapButtonAtPosition:(NSInteger)position;
- (CGFloat)toolbar:(ScrollToolbar *)toolbar widthForButton

@end
