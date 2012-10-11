//
//  PopupBalloonMenuBarItem.h
//
//

#import <Foundation/Foundation.h>

@interface PopupBalloonMenuBarItem : UIBarButtonItem {
    UIToolbar *_popupToolbar;
}

@property (nonatomic, retain) IBOutlet UIToolbar *popupToolbar;

@end
