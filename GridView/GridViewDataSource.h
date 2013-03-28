//
//  GridViewDataSource.h
//  Tulip
//
//  Created by huang yifeng on 13-3-25.
//  Copyright (c) 2013年 aimob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GridView, GridItemView;
@protocol GridViewDataSource <NSObject>

@optional
- (NSInteger)numberOfRowInGridView:(GridView *)gridView;
- (NSInteger)numberofColumnInGridView:(GridView *)gridView;

@required
- (GridItemView *)gridView:(GridView *)gridView gridUnitAtPosition:(NSInteger)index;
- (NSInteger)numberofItemInGridView:(GridView *)gridView;

@end
