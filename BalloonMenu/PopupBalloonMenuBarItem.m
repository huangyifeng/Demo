//
//  PopupBalloonMenuBarItem.m
//
//

#import "PopupBalloonMenuBarItem.h"

@implementation PopupBalloonMenuBarItem

@synthesize popupToolbar = _pupupToolbar;

- (void)dealloc
{
    [_popupToolbar release]; _popupToolbar = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.target = self;
    self.action = @selector(buttonPushed:event:);
}

- (void)buttonPushed:(UIBarButtonItem *)sender event:(UIEvent *)event;
{
    UIView *barButtonView = [[event.allTouches anyObject] view];
    CGRect frame = barButtonView.frame;
    CGFloat centerX = frame.origin.x + frame.size.width / 2;

//    [[GeminiAppDelegate rootViewController] showMenu:self.popupToolbar.items arrowPointX:centerX];
}

@end
