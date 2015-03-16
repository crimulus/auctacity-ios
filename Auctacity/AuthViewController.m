//
//  AuthViewController.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/10/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "AuthViewController.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setButtons:@""];
//    self.tagLine.delegate = self;
    self.buttonView.hidden = YES;

}

- (void)viewDidAppear:(BOOL)animated {
    APIRequest *loginRequest = [APIRequest alloc];
    if ([loginRequest loggedIn]) {
        LoginFormView *loginForm = [LoginFormView alloc];
        loginForm.viewController = self;
        [loginForm logIn];

    }
    else {
        self.buttonView.hidden = NO;
        [self.buttonView popIn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setButtons:(NSString *)type {

    NSString *leftText = @"Log In";
    NSString *rightText = @"Sign Up";

    SEL leftSelector = @selector(toggleLoginForm);
    SEL rightSelector = @selector(toggleJoinForm);

    if ([type isEqualToString:@"log in"]) {
        leftText = @"Cancel";
        leftSelector = @selector(toggleLoginForm);
    }

    [self.buttonView.leftButton setTitle:leftText forState:UIControlStateNormal];
    [self.buttonView.leftButton addTarget:self
                                   action:leftSelector
                         forControlEvents:UIControlEventTouchUpInside
     ];

    [self.buttonView.rightButton setTitle:rightText forState:UIControlStateNormal];
    [self.buttonView.rightButton addTarget:self
                                    action:rightSelector
                          forControlEvents:UIControlEventTouchUpInside
     ];

}

- (void)toggleLoginForm {

    CGAffineTransform zeroHeight = CGAffineTransformMakeScale(1, 0);
    CGAffineTransform fullHeight = CGAffineTransformMakeScale(1, 1);

    if (self.loginForm) {

        [UIView animateWithDuration:.1 animations:^{
            self.loginForm.container.transform = zeroHeight;
        } completion:^(BOOL finished) {

            [UIView animateWithDuration:.2 animations:^{
                self.shinyLip.transform = fullHeight;
                self.tagLine.transform = fullHeight;
            } completion:^(BOOL finished){
                [self.loginForm.container removeFromSuperview];
                self.loginForm = nil;
            }];

        }];
        [self setButtons:@""];

    }
    else {

        self.loginForm = [[LoginFormView alloc] init];
        [self.loginForm awakeFromNib];
        [self.loginForm setDelegates:self];

        self.loginForm.container.frame = CGRectMake(
                                                    (self.view.frame.size.width / 2) - (self.loginForm.container.frame.size.width / 2),
                                                    self.logo.frame.origin.y + self.logo.frame.size.height,
                                                    self.loginForm.container.frame.size.width,
                                                    self.loginForm.container.frame.size.height
                                                    );
        self.loginForm.container.transform = zeroHeight;

        [self.view addSubview:self.loginForm.container];
        [self.loginForm.username becomeFirstResponder];

        [UIView animateWithDuration:.2 animations:^{
            self.loginForm.container.transform = fullHeight;
            self.shinyLip.transform = zeroHeight;
            self.tagLine.transform = zeroHeight;
        } completion:^(BOOL finished){
        }];
        [self setButtons:@"log in"];
    }
}

- (void)toggleJoinForm {
    [self.buttonView popIn];

}

/**
 Text view delegate methods
 */

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO; // Otherwise you can "tab" from the input boxes to the tag line
}

/**
 End text view delegate methods
 */

/**
 Alert view delegate methods
 */

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Login Error"]) {
        [[[APIRequest alloc] init] logOut];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView {
}

/**
 End alert view delegate methods
 */

@end
