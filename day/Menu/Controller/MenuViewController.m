//
//  MenuViewController.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuView.h"
#import "SettingsViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController ()<SettingsViewControllerDelegate>{
    MenuView *_MenuView;
    SettingsViewController *_SettingsViewController;
    ProfileViewController *_ProfileViewController;
    bool _muted;
    
}
@end

@implementation MenuViewController

@synthesize audioPlayer = _audioPlayer;

- (void)viewDidLoad {
    NSLog(@"\n**** viewDidLoad: %@ ****\n",self.class);
    //http://www.orangefreesounds.com/terra-incognita-instrumental-music/#comments
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"backgroundMusic" ofType:@"mp3"]];
     _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [_audioPlayer setNumberOfLoops:-1];
    [_audioPlayer setVolume:.05];
    [_audioPlayer play];
    _muted = NO;
    [super viewDidLoad];
}

- (void)loadView{
    NSLog(@"\n**** loadView: %@ ****\n",self.class);
    
    _MenuView = [[MenuView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [_MenuView.playButton addTarget:self action:@selector(playButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_MenuView.playButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_MenuView.playButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_MenuView.playButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpOutside];
    [_MenuView.profileButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_MenuView.profileButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_MenuView.profileButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpOutside];
    [_MenuView.settingsButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_MenuView.settingsButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_MenuView.settingsButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpOutside];
    [_MenuView.settingsButton addTarget:self action:@selector(settingsButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_MenuView.profileButton addTarget:self action:@selector(profileButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self setView:_MenuView];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"\n**** didReceiveMemoryWarning: %@ ****\n",self.class);

    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated{
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

- (void) settingsButtonTapped{
    _SettingsViewController = [[SettingsViewController alloc] init];
    _SettingsViewController.delegate = self;
    
    self.definesPresentationContext = YES;
    _SettingsViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self.view addSubview:_SettingsViewController.view];
    
    _SettingsViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    
    _SettingsViewController.view.center = self.view.center;
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [self presentViewController:_SettingsViewController animated:NO completion:nil];
                         
                         _SettingsViewController.view.transform = CGAffineTransformMakeScale(1.03, 1.03);
                         [_SettingsViewController darkenBackground];
                         
                     }
                     completion:^(BOOL finished){
                     }];
    [UIView animateWithDuration:.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _SettingsViewController.view.transform = CGAffineTransformMakeScale(1.0,1.0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) profileButtonTapped{
    _ProfileViewController = [[ProfileViewController alloc] init];
    
    self.definesPresentationContext = YES;
    _ProfileViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
        [self.view addSubview:_ProfileViewController.view];
        
        _ProfileViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
        
    
        _ProfileViewController.view.center = self.view.center;
        
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             [self presentViewController:_ProfileViewController animated:NO completion:nil];

                             _ProfileViewController.view.transform = CGAffineTransformMakeScale(1.03, 1.03);
                             [_ProfileViewController darkenBackground];

                         }
                         completion:^(BOOL finished){
                         }];
    [UIView animateWithDuration:.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _ProfileViewController.view.transform = CGAffineTransformMakeScale(1.0,1.0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) playButtonTapped{
    
}

- (void) buttonPress:(UIButton*)button {
    //http://www.soundjay.com/button-sounds-5.html
    SystemSoundID soundID;
    NSURL *soundUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonClick" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.transform = CGAffineTransformMakeScale(.95,.95);
    } completion:^(BOOL finished) {
    
    }];
}

- (void) buttonRelease:(UIButton*)button {
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.transform = CGAffineTransformMakeScale(1.05,1.05);
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.transform = CGAffineTransformMakeScale(1.0,1.0);
    } completion:^(BOOL finished) {
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        
        [self loadView];
        
        //This is due to modal VC not being able to resize on rotate (close and relaunch)
        if(self.presentedViewController.class == SettingsViewController.class){
            [self settingsButtonTapped];
        }
        if(self.presentedViewController.class == ProfileViewController.class){
            [self profileButtonTapped];
        }
        
    } completion:^(id  _Nonnull context) {
        
    }];
}

-(void) signOutButtonTapped{
    [_audioPlayer stop];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void) muteButtonTapped{
    if(_muted){
        [_audioPlayer play];
        _muted = NO;
    }else{
        [_audioPlayer pause];
        _muted = YES;
    }
}

@end
