//
//  ScrollToolbarButton.h
//  Demo
//
//  Created by huang yifeng on 12-9-19.
//  Copyright (c) 2012年 , Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollToolbarButtonItem.h"

@interface ScrollToolbarButton : UIControl
{
@private
    
    //model
    ScrollToolbarButtonItem *_toolbarItem;
    
    //view
    UILabel         *_buttonNameLabel;
    UIImageView     *_buttonImageView;
}

@property(nonatomic, retain)ScrollToolbarButtonItem *toolbarItem;

- (id)initWithToolbarItem:(ScrollToolbarButtonItem *)toolbarItem;

@end
