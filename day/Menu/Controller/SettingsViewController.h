//
//  SettingsViewController.h
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate
@required
-(void)signOutButtonTapped;
-(void)muteButtonTapped;
@end

@interface SettingsViewController : UIViewController
@property (weak) id <SettingsViewControllerDelegate> delegate;

-(void) darkenBackground;
@end
