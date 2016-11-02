//
//  ProfileView.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "ProfileView.h"
#import "UIView+Autolayout.h"
#import "SunflowerCommon.h"
#import "day-Swift.h"

@interface ProfileView() {
    UIView *_menuBackgroundOutter;
    UIView *_menuBackgroundInnner;
    UILabel *_SettingsTitle;
    UILabel *_scoreLabel;
    UILabel *_totalPointsLabel;
    UILabel *_maxStreakLabel;
    UILabel *_gamesPlayedLabel;
    UIView *temp;
    long _score;
    long _totalPoints;
    long _maxStreak;
    long _gamesPlayed;
}
@end

@interface ProfileView(Private)
-(void)setupSettingsView;
@end

@implementation ProfileView

@synthesize exitButton = _exitButton;
@synthesize background = _background;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSettingsView];
    }
    return self;
}

@end

@implementation ProfileView(Private)
- (void) setupSettingsView{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setupBackground];
    [self setupMenuOutter];
    [self setupMenuInner];
    [self setupExitButton];
    [self setupTitle];
    [self setupStats];
}

- (void) setupBackground{
    _background = [[UIView alloc]initWithFrame:CGRectZero];
    [_background setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_background];
    
    [_background addTopConstraint:0];
    [_background addBottomConstraint:0];
    [_background addLeadingConstraint:0];
    [_background addTrailingConstraint:0];
    
    [_background setBackgroundColor:[UIColor clearColor]];
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
    
    [_SettingsTitle setText:@"Profile"];
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

- (void) setupStats{
    _score = FirebaseHelper.highscore;
    _totalPoints = FirebaseHelper.coins;
    _maxStreak = FirebaseHelper.streak;
    _gamesPlayed = FirebaseHelper.gamesPlayed;
    
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _totalPointsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _maxStreakLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _gamesPlayedLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    
    [_scoreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundInnner addSubview:_scoreLabel];
    [_totalPointsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundInnner addSubview:_totalPointsLabel];
    [_maxStreakLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundInnner addSubview:_maxStreakLabel];
    [_gamesPlayedLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_menuBackgroundInnner addSubview:_gamesPlayedLabel];
    
    [_scoreLabel addLeadingConstraint:PROFILE_LEFT_LEADING];
    [_scoreLabel addTrailingConstraint:PROFILE_LEFT_TRAILING];
    [_scoreLabel addHeightConstraint:50];
    [_scoreLabel addTopConstraint:5];
    [_totalPointsLabel addLeadingConstraint:PROFILE_LEFT_LEADING];
    [_totalPointsLabel addHeightConstraint:50];
    [_totalPointsLabel addTrailingConstraint:PROFILE_LEFT_TRAILING];
    [_totalPointsLabel addTopConstraint:55];
    [_maxStreakLabel addLeadingConstraint:PROFILE_RIGHT_LEADING];
    [_maxStreakLabel addHeightConstraint:50];
    [_maxStreakLabel addTrailingConstraint:PROFILE_RIGHT_TRAILING];
    [_maxStreakLabel addTopConstraint:PROFILE_RIGHT_TOP2];
    [_gamesPlayedLabel addLeadingConstraint:PROFILE_RIGHT_LEADING];
    [_gamesPlayedLabel addHeightConstraint:50];
    [_gamesPlayedLabel addTrailingConstraint:PROFILE_RIGHT_TRAILING];
    [_gamesPlayedLabel addTopConstraint:PROFILE_RIGHT_TOP1];

    
    [_scoreLabel setText:[NSString stringWithFormat:@"Highscore: %ld", _score] ];
    [_scoreLabel setTextColor:[UIColor blackColor]];
    [_scoreLabel setAdjustsFontSizeToFitWidth:YES];
    [_scoreLabel setFont:[UIFont systemFontOfSize:20]];
    [_scoreLabel setTextAlignment:PROFILE_LEFT_TEXT_ORIENTATION];
    [_totalPointsLabel setText:[NSString stringWithFormat:@"Total Points: %ld", _totalPoints] ];
    [_totalPointsLabel setTextColor:[UIColor blackColor]];
    [_totalPointsLabel setAdjustsFontSizeToFitWidth:YES];
    [_totalPointsLabel setFont:[UIFont systemFontOfSize:20]];
    [_totalPointsLabel setTextAlignment:PROFILE_LEFT_TEXT_ORIENTATION];
    [_maxStreakLabel setText:[NSString stringWithFormat:@"Max Streak: %ld", _maxStreak] ];
    [_maxStreakLabel setTextColor:[UIColor blackColor]];
    [_maxStreakLabel setAdjustsFontSizeToFitWidth:YES];
    [_maxStreakLabel setFont:[UIFont systemFontOfSize:20]];
    [_maxStreakLabel setTextAlignment:PROFILE_RIGHT_TEXT_ORIENTATION];
    [_gamesPlayedLabel setText:[NSString stringWithFormat:@"Games Played: %ld", _gamesPlayed] ];
    [_gamesPlayedLabel setTextColor:[UIColor blackColor]];
    [_gamesPlayedLabel setAdjustsFontSizeToFitWidth:YES];
    [_gamesPlayedLabel setFont:[UIFont systemFontOfSize:20]];
    [_gamesPlayedLabel setTextAlignment:PROFILE_RIGHT_TEXT_ORIENTATION];
    
}

@end
