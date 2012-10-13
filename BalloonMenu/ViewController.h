//
//  ViewController.h
//  BalloonMenu
//
//  Created by huang yifeng on 12-10-10.
//  Copyright (c) 2012年 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalloonMenu.h"

@interface ViewController : UIViewController
{
@private
    BalloonMenu *_balloonMenu;
}

@property(nonatomic, retain) IBOutlet UIToolbar *_balloonToolbar;

- (IBAction)teamButtonPressed:(id)sender;

@end
