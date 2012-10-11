//
//  BalloonMenu.m
//
//

#import "BalloonMenu.h"

#import "BalloonMenuCell.h"
#import "BalloonMenuSeparatorBarItem.h"
#import "BalloonMenuSeparatorCell.h"

static NSInteger const SCREEN_HEIGHT       = 460;
static NSInteger const MENTARROW_Y_ORIGIN  = 43;
static CGFloat   const MENTARROW_NOT_INDENT_HEIGHT    = -7.5;
static CGFloat   const DEFAULT_MAX_TABLE_HEIGHT = 200;

@interface BalloonMenu()

@property(nonatomic, assign)CGPoint _startPoint;

@end

@implementation BalloonMenu

@synthesize menuItems = _menuItems;
@synthesize _menuTable;
@synthesize _menuArrow;
@synthesize _startPoint;

- (void)dealloc
{
    [_menuItems release]; _menuItems = nil;
    [_menuTable release]; _menuTable = nil;
    [_menuArrow release]; _menuArrow = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.orientation = BallonMenuPopupOrientationDown;
        self.isFlexible  = YES;
    }
    return self;
}

- (void)showBalloonMenu:(UIView *)onView fromPoint:(CGPoint)point
{
//    self._viewFromLeft = (point.x < 160);
    self._startPoint = point;

    //init
    [self._menuTable reloadData];
    [onView addSubview:self.view];
    self.view.alpha = 0;
    self._menuTable.frame = CGRectMake(point.x, point.y, 1, 1);
    self._menuArrow.frame = CGRectMake(point.x, point.y, 1, 1);

    //compute size
    //table size
    CGFloat headerHeight = self._menuTable.tableHeaderView.frame.size.height;
    CGFloat menuHeight = 0;
    for (UIBarItem *barItem in self.menuItems)
    {
        menuHeight += [barItem isKindOfClass:[BalloonMenuSeparatorBarItem class]] ? 11 : 40;
    }
    CGFloat footerHeight = self._menuTable.tableFooterView.frame.size.height;
    CGFloat tableHeight = menuHeight + headerHeight + footerHeight;
    tableHeight = MIN(tableHeight, DEFAULT_MAX_TABLE_HEIGHT);
    
    //Image arrow size
    CGFloat arrowWidth = self._menuArrow.image.size.width;
    CGFloat arrowHeight = self._menuArrow.image.size.height;

    //compute position
    //adjust input point X
    CGFloat minArrowPointX = round(arrowWidth / 2 + 0.5);
    CGFloat maxArrowPointX = 320 - round(arrowWidth / 2 + 0.5);
    
    point.x = MAX(point.x, minArrowPointX);
    point.x = MIN(point.x, maxArrowPointX);
    
    CGFloat menuTableMinPointX = -5;
    CGFloat menuTableMaxPointX = 123;
    CGFloat menuTableWidth = 202;
    CGFloat tableDeviation = menuTableWidth / 2;
    
    CGFloat menuTablePointX = point.x - tableDeviation;
    
    menuTablePointX = MAX(menuTablePointX, menuTableMinPointX);
    menuTablePointX = MIN(menuTablePointX, menuTableMaxPointX);
    
    
    
    
    //============
    [UIView beginAnimations:@"open_menu_panel" context:nil];

    self.view.alpha = 1;



    if ((SCREEN_HEIGHT - MENTARROW_Y_ORIGIN - tableHeight) >= 0)
    {
        self._menuTable.frame = CGRectMake(menuTablePointX, SCREEN_HEIGHT - MENTARROW_Y_ORIGIN - tableHeight, menuTableWidth, tableHeight);
    }
    else
    {
        self._menuTable.frame = CGRectMake(menuTablePointX, MENTARROW_NOT_INDENT_HEIGHT, menuTableWidth, SCREEN_HEIGHT - MENTARROW_Y_ORIGIN);
        self._menuTable.scrollEnabled = YES;
        self._menuTable.contentSize = CGSizeMake(self._menuTable.frame.size.width, tableHeight + MENTARROW_NOT_INDENT_HEIGHT);
        self._menuTable.scrollsToTop = YES;
        self._menuTable.bounces = NO;
        self._menuTable.showsVerticalScrollIndicator = NO;
    }

    //submit 1/2 image width
    pointX = pointX - round(arrowWidth / 2 + 0.5);

    self._menuArrow.frame =CGRectMake(pointX, arrowPointY, arrowWidth, arrowHeight);

    [UIView commitAnimations];
}

- (void)_menuClosed
{
    [self.view removeFromSuperview];
}

- (IBAction)closeBalloonMenu
{
    [UIView animateWithDuration:0.2 animations:^{
        self._menuTable.frame = CGRectMake(self._startPoint.x, self._startPoint.y, 1, 1);
        self._menuArrow.frame = CGRectMake(self._startPoint.x, self._startPoint.y, 1, 1);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self _menuClosed];
    }];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger menucount = [self.menuItems count];
    return menucount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarItem *item = [self.menuItems objectAtIndex:indexPath.row];
    
    if ([item isKindOfClass:[BalloonMenuSeparatorBarItem class]])
    {
        return 11;        
    }
    else
    {
        return 40;
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarItem *item = [self.menuItems objectAtIndex:indexPath.row];
    
    if ([item isKindOfClass:[BalloonMenuSeparatorBarItem class]])
    {
        static NSString *CellIdentifier = @"BalloonMenuSeparatorCell";
        
        BalloonMenuSeparatorCell *cell = (BalloonMenuSeparatorCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [UITableViewCell cellWithNibName:@"BalloonMenuSeparatorCell"];
        }
        
        return cell;        
    }
    else
    {
        static NSString *CellIdentifier = @"BalloonMenuCell";

        BalloonMenuCell *cell = (BalloonMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [UITableViewCell cellWithNibName:@"BalloonMenuCell"];
        }

        [cell setElement:item];
        return cell;
    }    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIBarItem *barItem = [self.menuItems objectAtIndex:indexPath.row];

    if ([barItem isKindOfClass:[UIBarButtonItem class]])
    {
        UIBarButtonItem *menuItem = (UIBarButtonItem *)barItem;
        if (menuItem.enabled)
        {
            //[menuItem.target performSelector:menuItem.action];
            [menuItem.target performSelector:menuItem.action withObject:menuItem];
            [self closeBalloonMenu];
        }
    }
}

@end
