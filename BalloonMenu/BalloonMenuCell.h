//
//  BalloonMenuCell.h
//
//

#import <UIKit/UIKit.h>

@interface BalloonMenuCell : UITableViewCell
{
    UIImageView        *_iconView;
    UILabel            *_itemLabel;
}

@property (nonatomic, retain)IBOutlet UIImageView      *iconView;
@property (nonatomic, retain)IBOutlet UILabel          *itemLabel;

- (void)setElement:(UIBarItem *)barItem;

@end
