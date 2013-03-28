//
//  GridViewDelegate.h
//  Tulip
//
//  Created by huang yifeng on 13-3-25.
//  Copyright (c) 2013年 aimob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GridView,GridItemView;
@protocol GridViewDelegate <NSObject>

- (void)girdView:(GridView *)gridView didSelectItemAtIndex:(NSInteger)index;

@end
