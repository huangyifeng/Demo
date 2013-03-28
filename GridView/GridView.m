//
//  GridView.m
//  Tulip
//
//  Created by huang yifeng on 13-3-25.
//  Copyright (c) 2013年 aimob. All rights reserved.
//

static NSInteger const k_default_column_count = 4;
static NSInteger const k_default_row_count = 3;

#import "GridView.h"

@interface GridView ()

//UI
@property(nonatomic, strong)UIScrollView    *_scrollView;
@property(nonatomic, strong)NSMutableArray  *_gridItemArray;
@property(nonatomic, strong)NSMutableArray  *_itemPool;

- (void)initialize;
- (void)initComponent;
- (void)loadParam;
- (void)layoutItem;

@end


@implementation GridView

@synthesize _scrollView;

@synthesize datasource;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - private

- (void)initialize
{
    [self initComponent];
    [self loadParam];
}

- (void)initComponent
{
    self._scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
}

- (void)loadParam
{
    if ([self.datasource respondsToSelector:@selector(numberofItemInGridView:)])
    {
        _itemCount = [self.datasource numberofItemInGridView:self];
    }
    
    if (GridViewScrollDiectionHorizontal == self.scrollDirection)
    {
        if ([self.datasource respondsToSelector:@selector(numberOfRowInGridView:)])
        {
            _rowCount = [self.datasource numberOfRowInGridView:self];
        }
        _columnCount = ceil((float)_itemCount / _rowCount);
    }
    else if(GridViewScrollDiectionHorizontal == self.scrollDirection)
    {
        if ([self.datasource respondsToSelector:@selector(numberofColumnInGridView:)])
        {
            _columnCount = [self.datasource numberofColumnInGridView:self];
        }
        _rowCount = ceil((float)_itemCount / _columnCount);
    }
    
}

@end
