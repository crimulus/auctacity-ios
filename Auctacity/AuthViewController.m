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
    self.tagLine.delegate = self;
    self.buttonView.hidden = YES;

}

- (void)viewDidAppear:(BOOL)animated {
    APIRequest *loginRequest = [APIRequest alloc];
    if ([loginRequest loggedIn]) {
        LoginFormView *loginForm = [LoginFormView alloc];
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
    if (self.loginForm) {

        [UIView animateWithDuration:.1 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(1, 0);
            self.loginForm.container.transform = transform;
        } completion:^(BOOL finished) {

            [UIView animateWithDuration:.2 animations:^{
                self.logo.frame = CGRectMake(
                                             self.logo.frame.origin.x,
                                             self.logo.frame.origin.y + 50,
                                             self.logo.frame.size.width,
                                             self.logo.frame.size.height
                                             );
                self.shinyLip.frame = CGRectMake(
                                                 self.shinyLip.frame.origin.x,
                                                 self.shinyLip.frame.origin.y + 50,
                                                 self.shinyLip.frame.size.width,
                                                 self.shinyLip.frame.size.height
                                                 );
                self.tagLine.frame = CGRectMake(
                                                self.tagLine.frame.origin.x,
                                                self.tagLine.frame.origin.y - 270,
                                                self.tagLine.frame.size.width,
                                                self.tagLine.frame.size.height
                                                );
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

        self.loginForm.container.frame = CGRectMake(
                                                    (self.view.frame.size.width / 2) - (self.loginForm.container.frame.size.width / 2),
                                                    (self.view.frame.size.height / 2) - 170,
                                                    self.loginForm.container.frame.size.width,
                                                    self.loginForm.container.frame.size.height
                                                    );
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 0);
        self.loginForm.container.transform = transform;

        [self.loginForm setDelegate:self];
        [self.view addSubview:self.loginForm.container];
        [self.loginForm.username becomeFirstResponder];

        [UIView animateWithDuration:.2 animations:^{
            self.logo.frame = CGRectMake(
                                         self.logo.frame.origin.x,
                                         self.logo.frame.origin.y - 50,
                                         self.logo.frame.size.width,
                                         self.logo.frame.size.height
                                         );
            self.shinyLip.frame = CGRectMake(
                                             self.shinyLip.frame.origin.x,
                                             self.shinyLip.frame.origin.y - 50,
                                             self.shinyLip.frame.size.width,
                                             self.shinyLip.frame.size.height
                                             );
            self.tagLine.frame = CGRectMake(
                                            self.tagLine.frame.origin.x,
                                            self.tagLine.frame.origin.y + 270,
                                            self.tagLine.frame.size.width,
                                            self.tagLine.frame.size.height
                                            );
        } completion:^(BOOL finished){
            [UIView animateWithDuration:.1 animations:^{
                CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
                self.loginForm.container.transform = transform;
            } completion:^(BOOL finished){
            }];
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

@end
