//
//  ProfileViewController.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import <AVFoundation/AVFoundation.h>


@interface ProfileViewController (){
    ProfileView *_profileView;
}
@end

@implementation ProfileViewController


- (void)viewDidLoad {
    NSLog(@"\n**** viewDidLoad: %@ ****\n",self.class);

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadView{
    NSLog(@"\n**** loadView: %@ ****\n",self.class);

    _profileView = [[ProfileView alloc] initWithFrame:CGRectZero];
    [_profileView.exitButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.exitButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_profileView.exitButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.exitButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpOutside];

    UILongPressGestureRecognizer *singleFingerTap =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(dismissView)];
    singleFingerTap.minimumPressDuration=0;
    [_profileView.background addGestureRecognizer:singleFingerTap];

    
    [self setView:_profileView];
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


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    
    // best call super just in case
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // will execute before rotation
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        
        //This is due to modal VC not being able to resize on rotate
        [self dismissViewControllerAnimated:NO completion:nil];

       
    } completion:^(id  _Nonnull context) {
        
    }];
}

- (void) buttonPress:(UIButton*)button {
    //http://www.soundjay.com/button-sounds-5.html
    SystemSoundID soundID;
    NSURL *soundUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonClick" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.transform = CGAffineTransformMakeScale(.9,.9);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) buttonRelease:(UIButton*)button {
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.transform = CGAffineTransformMakeScale(1.05,1.05);
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:.2 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.transform = CGAffineTransformMakeScale(1.0,1.0);
    } completion:^(BOOL finished) {
    }];
}

- (void) dismissView{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)darkenBackground{
   [ _profileView.background setBackgroundColor: [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:0.8]];

}
@end
