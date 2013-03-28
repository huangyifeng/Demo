//
//  GridView.h
//  Tulip
//
//  Created by huang yifeng on 13-3-25.
//  Copyright (c) 2013年 aimob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewDelegate.h"
#import "GridViewDataSource.h"
#import "GridViewEnum.h"

@interface GridView : UIView
{
@private
    NSInteger   _columnCount;
    NSInteger   _rowCount;
    NSInteger   _itemCount;
}

@property(nonatomic, assign)GridViewScrollDiection  scrollDirection;

@property(nonatomic, assign)IBOutlet id<GridViewDataSource> datasource;
@property(nonatomic, assign)IBOutlet id<GridViewDelegate>   delegate;

@end
