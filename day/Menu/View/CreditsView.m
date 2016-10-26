//
//  CreditsView.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "CreditsView.h"
#import "UIView+Autolayout.h"
#import "SunflowerCommon.h"

@interface CreditsView() {
    UITextView *_textView;
}
@end

@interface CreditsView(Private)
- (void)setupCreditsView;
@end

@implementation CreditsView

@synthesize dismissButton = _dismissButton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCreditsView];
    }
    return self;
}


@end

@implementation CreditsView(Private)
- (void) setupCreditsView{
    [self setupTextView];
    [self setupDismissButton];
    [self setBackgroundColor: [UIColor blackColor]];
}

- (void) setupTextView{
    _textView = [[UITextView alloc]initWithFrame:CGRectZero];
    [_textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_textView];
    
    [_textView addBottomConstraint:15];
    [_textView addTrailingConstraint:15];
    [_textView addLeadingConstraint:15];
    [_textView addTopConstraint:15];
    
    [_textView setText:@"Sunflower\n\nConnor Wood\nBenjamin Stammen\nMicheal Mascolino\n OSU CSE 5236\n Mobile App Dev\n"];
    [_textView setBackgroundColor:[UIColor blackColor]];
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:30]];
    [_textView setEditable:NO];
    [_textView setScrollEnabled:YES];
    [_textView setTextAlignment:NSTextAlignmentCenter];
    
}

//lazy man tap to exit, dont wanna register all clicks
- (void) setupDismissButton{
    _dismissButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_dismissButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_dismissButton];
    
    [_dismissButton addLeadingConstraint:0];
    [_dismissButton addBottomConstraint:0];
    [_dismissButton addTopConstraint:0];
    [_dismissButton addTrailingConstraint:0];
    
    [_dismissButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
}

@end
