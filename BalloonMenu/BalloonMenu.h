//
//  BalloonMenu.h
//
//

#import <UIKit/UIKit.h>

typedef enum {
    BallonMenuPopupOrientationDown,
    BallonMenuPopupOrientationUp
}BallonMenuPopupOrientation;

@interface BalloonMenu : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    NSArray     *_menuItems;
    UITableView *_menuTable;
	UIImageView *_menuArrow;

    BOOL         _viewFromLeft;
}

@property(nonatomic, retain)          NSArray     *menuItems;
@property(nonatomic, assign)          BallonMenuPopupOrientation    orientation; //default is down
@property(nonatomic, assign)          BOOL        isFlexible; //default is Yes
@property(nonatomic, assign)          CGFloat     maxTableHeight; //

@property(nonatomic, retain) IBOutlet UITableView *_menuTable;
@property(nonatomic, retain) IBOutlet UIImageView *_menuArrow;

- (void)showBalloonMenu:(UIView *)onView fromPoint:(CGPoint)point;
- (IBAction)closeBalloonMenu;

@end

