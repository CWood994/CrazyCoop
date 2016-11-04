//
//  EULAView.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "EULAView.h"
#import "UIView+Autolayout.h"
#import "SunflowerCommon.h"

@interface EULAView() {
    UITextView *_textView;
}
@end

@interface EULAView(Private)
- (void)setupCreditsView;
@end

@implementation EULAView

@synthesize dismissButton = _dismissButton;
@synthesize acceptButton = _acceptButton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCreditsView];
    }
    return self;
}


@end

@implementation EULAView(Private)
- (void) setupCreditsView{
    [self setupTextView];
    [self setupDismissButton];
    [self setupAcceptButton];
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
    
    [_textView setText:@"EULA:\n You agreed to let us use everything and do whatever we want.\n"];
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
    
    [_dismissButton addWidthConstraint:100];
    [_dismissButton addBottomConstraint:10];
    [_dismissButton addHeightConstraint:50];
    [_dismissButton addLeadingConstraint:10];
    
    [_dismissButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
    [_dismissButton setTitle:@"Decline" forState:UIControlStateNormal];
}

- (void) setupAcceptButton{
    _acceptButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_acceptButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_acceptButton];
    
    [_acceptButton addWidthConstraint:100];
    [_acceptButton addBottomConstraint:10];
    [_acceptButton addHeightConstraint:50];
    [_acceptButton addTrailingConstraint:10];
    
    [_acceptButton setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:1]];
    [_acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
    [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

@end
