//
//  BalloonMenuCell.m
//
//

#import "BalloonMenuCell.h"

@implementation BalloonMenuCell

@synthesize iconView = _iconView;
@synthesize itemLabel = _itemLabel;

- (void)dealloc
{
    [_iconView release]; _iconView = nil;
    [_itemLabel release]; _itemLabel = nil;

    [super dealloc];
}

- (void)awakeFromNib
{
    self.backgroundView = [UIView geminiBackgroundViewWith:@"common_balloon_button"];
    self.selectedBackgroundView = [UIView geminiBackgroundViewWith:@"common_balloon_button_select"];
}

- (void)setElement:(UIBarItem *)barItem
{
    self.iconView.image = barItem.image;
    self.itemLabel.text = barItem.title;

    if (barItem.enabled)
    {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.iconView.alpha = 1;
        self.itemLabel.alpha = 1;
    }
    else
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.iconView.alpha = 0.4;
        self.itemLabel.alpha = 0.4;
    }

    if (self.iconView.image == nil)
    {
        self.itemLabel.frame = CGRectMake(22, 10, 190, 13);
    }
    else
    {
        self.itemLabel.frame = CGRectMake(47, 10, 147, 13);
    }
}

@end
