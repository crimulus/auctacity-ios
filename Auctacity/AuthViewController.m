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
    
    [self.buttonView.leftButton setTitle:@"Log In" forState:UIControlStateNormal];
    [self.buttonView.leftButton addTarget:self
                                   action:@selector(toggleLoginForm)
                         forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self.buttonView.rightButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.buttonView.rightButton addTarget:self
                                    action:@selector(toggleJoinForm)
                          forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self.buttonView popIn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toggleLoginForm {
    if (self.loginForm) {
        
        [UIView animateWithDuration:.1 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(1, .01);
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
        
    }
    else {
        
        self.loginForm = [[LoginFormView alloc] init];
        [self.loginForm awakeFromNib];
        
        self.loginForm.container.frame = CGRectMake(
                                                    (self.view.frame.size.width / 2) - (self.loginForm.container.frame.size.width / 2),
                                                    (self.view.frame.size.height / 2) - (self.loginForm.container.frame.size.height),
                                                    self.loginForm.container.frame.size.width,
                                                    self.loginForm.container.frame.size.height
                                                    );
        CGAffineTransform transform = CGAffineTransformMakeScale(1, .01);
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
        [self.buttonView popOut];
    }
}

- (void)toggleJoinForm {
    [self.buttonView popIn];
    
}

/**
 Text Field delegate methods
 */

/**
 End text Field delegate methods
 */


@end
