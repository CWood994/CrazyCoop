//
//  SettingsView.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "SettingsView.h"
#import "UIView+Autolayout.h"
#import "SunflowerCommon.h"

@interface SettingsView() {
    UIView *_menuBackgroundOutter;
    UIView *_menuBackgroundInnner;
    UILabel *_SettingsTitle;
}
@end

@interface SettingsView(Private)
-(void)setupSettingsView;
@end

@implementation SettingsView

@synthesize exitButton = _exitButton;
@synthesize background = _background;
@synthesize creditsButton = _creditsButton;
@synthesize signOutButton = _signOutButton;
@synthesize gameSettingsButton = _gameSettingsButton;
@synthesize tbdButton = _tbdButton;
@synthesize quitButton = _quitButton;
@synthesize muteButton = _muteButton;



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSettingsView];
    }
    return self;
}

@end

@implementation SettingsView(Private)
- (void) setupSettingsView{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setupBackground];
    [self setupMenuOutter];
    //[self setupMenuInner];
    [self setupExitButton];
    [self setupTitle];
    [self setupCreditsButton];
    [self setupSignOutButton];
    [self setupGameSettingsButton];
    [self setupTBDButton];
    [self setupMuteButton];
    [self setupQuitButton];

}

- (void) setupBackground{
    _background = [[UIView alloc]initWithFrame:CGRectZero];
    [_background setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_background];
    
    [_background addTopConstraint:0];
    [_background addBottomConstraint:0];
    [_background addLeadingConstraint:0];
    [_background addTrailingConstraint:0];
    
    [_background setBackgroundColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:0.8]];
}

- (void) setupMenuOutter{
    _menuBackgroundOutter = [[UIView alloc]initWithFrame:CGRectZero];
    [_menuBackgroundOutter setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_menuBackgroundOutter];
    
    [_menuBackgroundOutter addTopConstraint:30];
    [_menuBackgroundOutter addBottomConstraint:30];
    [_menuBackgroundOutter addLeadingConstraint:30];
    [_menuBackgroundOutter addTrailingConstraint:30];
    
    [_menuBackgroundOutter.layer setCornerRadius:30];
    [_menuBackgroundOutter.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_menuBackgroundOutter.layer setBorderWidth:2];
    [_menuBackgroundOutter setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
}

- (void) setupMenuInner{
    _menuBackgroundInnner = [[UIView alloc]initWithFrame:CGRectZero];
    [_menuBackgroundInnner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_menuBackgroundInnner];
    
    [_menuBackgroundInnner addTopConstraint:50];
    [_menuBackgroundInnner addBottomConstraint:10];
    [_menuBackgroundInnner addLeadingConstraint:12];
    [_menuBackgroundInnner addTrailingConstraint:12];
    
    [_menuBackgroundInnner.layer setCornerRadius:30];
    [_menuBackgroundInnner.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_menuBackgroundInnner.layer setBorderWidth:2];
    [_menuBackgroundInnner setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    
}

- (void) setupTitle{
    _SettingsTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    [_SettingsTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_SettingsTitle];
    
    [_SettingsTitle addWidthConstraint:200];
    [_SettingsTitle addHeightConstraint:50];
    [_SettingsTitle addCenterXConstraint];
    [_SettingsTitle addTopConstraint:2];
    
    [_SettingsTitle setText:@"Settings"];
    [_SettingsTitle setTextColor:[UIColor whiteColor]];
    [_SettingsTitle setAdjustsFontSizeToFitWidth:YES];
    [_SettingsTitle setFont:[UIFont boldSystemFontOfSize:30]];
    [_SettingsTitle setTextAlignment:NSTextAlignmentCenter];
}

- (void) setupExitButton{
    _exitButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_exitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_exitButton];
    
    [_exitButton addWidthConstraint:30];
    [_exitButton addHeightConstraint:30];
    [_exitButton addTopConstraint:10];
    [_exitButton addTrailingConstraint:10];

    [_exitButton setBackgroundImage:[UIImage imageNamed:@"CloseButton.png"] forState:UIControlStateNormal];
    _exitButton.adjustsImageWhenHighlighted = NO;

}

- (void) setupCreditsButton{
    _creditsButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_creditsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_creditsButton];
    
    [_creditsButton addLeadingConstraint:12];
    [_creditsButton addHeightConstraint:SETTINGS_BUTTON_HEIGHT];
    [_creditsButton addTopConstraint:50];
    [_creditsButton addTrailingConstraint:12];
    
    [_creditsButton setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_creditsButton.layer setCornerRadius:10];
    [_creditsButton.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_creditsButton.layer setBorderWidth:2];
    [_creditsButton setTitle:@"Credits" forState:UIControlStateNormal];
    [_creditsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _creditsButton.titleLabel.font = [UIFont systemFontOfSize:30];
}

- (void) setupSignOutButton{
    _signOutButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_signOutButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_signOutButton];
    
    [_signOutButton addLeadingConstraint:12];
    [_signOutButton addHeightConstraint:SETTINGS_BUTTON_HEIGHT];
    [_signOutButton addTopConstraint:SETTINGS_SIGN_OUT_TOP];
    [_signOutButton addTrailingConstraint:12];
    
    [_signOutButton setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_signOutButton.layer setCornerRadius:10];
    [_signOutButton.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_signOutButton.layer setBorderWidth:2];
    [_signOutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
    [_signOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _signOutButton.titleLabel.font = [UIFont systemFontOfSize:30];
}

- (void) setupGameSettingsButton{
    _gameSettingsButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_gameSettingsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_gameSettingsButton];
    
    [_gameSettingsButton addLeadingConstraint:12];
    [_gameSettingsButton addHeightConstraint:SETTINGS_BUTTON_HEIGHT];
    [_gameSettingsButton addTopConstraint:SETTINGS_GAME_SETTINGS_TOP];
    [_gameSettingsButton addTrailingConstraint:12];
    
    [_gameSettingsButton setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_gameSettingsButton.layer setCornerRadius:10];
    [_gameSettingsButton.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_gameSettingsButton.layer setBorderWidth:2];
    [_gameSettingsButton setTitle:@"Game Settings" forState:UIControlStateNormal];
    [_gameSettingsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _gameSettingsButton.titleLabel.font = [UIFont systemFontOfSize:30];
}

- (void) setupTBDButton{
    _tbdButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_tbdButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_tbdButton];
    
    [_tbdButton addLeadingConstraint:12];
    [_tbdButton addHeightConstraint:SETTINGS_BUTTON_HEIGHT];
    [_tbdButton addTopConstraint:SETTINGS_TBD_TOP];
    [_tbdButton addTrailingConstraint:12];
    
    [_tbdButton setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_tbdButton.layer setCornerRadius:10];
    [_tbdButton.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_tbdButton.layer setBorderWidth:2];
    [_tbdButton setTitle:@"TBD" forState:UIControlStateNormal];
    [_tbdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _tbdButton.titleLabel.font = [UIFont systemFontOfSize:30];
}

- (void) setupMuteButton{
    _muteButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_muteButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_muteButton];
    
    [_muteButton addLeadingConstraint:12];
    [_muteButton addHeightConstraint:SETTINGS_BUTTON_HEIGHT];
    [_muteButton addTopConstraint:SETTINGS_MUTE_TOP];
    [_muteButton addWidthConstraint:110];
    
    [_muteButton setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_muteButton.layer setCornerRadius:10];
    [_muteButton.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_muteButton.layer setBorderWidth:2];
    [_muteButton setTitle:@"Mute" forState:UIControlStateNormal];
    [_muteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _muteButton.titleLabel.font = [UIFont systemFontOfSize:25];
}

- (void) setupQuitButton{
    _quitButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_quitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundOutter addSubview:_quitButton];
    
    [_quitButton addWidthConstraint:110];
    [_quitButton addHeightConstraint:SETTINGS_BUTTON_HEIGHT];
    [_quitButton addTopConstraint:SETTINGS_QUIT_TOP];
    [_quitButton addTrailingConstraint:12];
    
    [_quitButton setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_quitButton.layer setCornerRadius:10];
    [_quitButton.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor];
    [_quitButton.layer setBorderWidth:2];
    [_quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [_quitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _quitButton.titleLabel.font = [UIFont systemFontOfSize:25];
}

@end
