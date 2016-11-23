//
//  EULAViewController.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "EULAViewController.h"
#import "EULAView.h"
#import "day-Swift.h"


@interface EULAViewController (){
    EULAView *_eulaView;
}
@end

@implementation EULAViewController

@synthesize quitOnDecline = _quitOnDecline;

- (void)viewDidLoad {
    NSLog(@"\n**** viewDidLoad: %@ ****\n",self.class);
    
    [super viewDidLoad];
}

- (void)loadView{
    NSLog(@"\n**** loadView: %@ ****\n",self.class);
    
    _eulaView = [[EULAView alloc] initWithFrame:CGRectZero];
    [_eulaView.acceptButton addTarget:self action:@selector(acceptButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_eulaView.dismissButton addTarget:self action:@selector(declineButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self setView:_eulaView];
    }

- (void)didReceiveMemoryWarning {
    NSLog(@"\n**** didReceiveMemoryWarning: %@ ****\n",self.class);

    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"\n**** viewWillAppear: %@ ****\n",self.class);

}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"\n**** viewDidAppear: %@ ****\n",self.class);

    
}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"\n**** viewWillDisappear: %@ ****\n",self.class);

}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"\n**** viewDidDisappear: %@ ****\n",self.class);

    
}

-(void)viewDidLayoutSubviews{
    NSLog(@"\n**** viewDidLayoutSubviews: %@ ****\n",self.class);
    
    
}


-(void) acceptButtonTapped{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ACCEPTED_EULA_BIRD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) declineButtonTapped{
    if(_quitOnDecline==true){
        [self quitButtonTapped];
    }else{
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ACCEPTED_EULA_BIRD"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)quitButtonTapped
{
    //show confirmation message to user
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Confirmation"
                                                    message:@"Decline?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [FirebaseHelper sendLogoutEvent];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ACCEPTED_EULA_BIRD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (buttonIndex != 0)  // 0 == the cancel button
    {
        //home button press programmatically
        UIApplication *app = [UIApplication sharedApplication];
        [app performSelector:@selector(suspend)];
        
        //wait 2 seconds while app is going background
        [NSThread sleepForTimeInterval:2.0];
        
        //exit app when app is in background
        exit(0);
    }
}

@end
