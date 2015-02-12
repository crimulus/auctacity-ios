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
                                   action:@selector(showLoginForm)
                         forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self.buttonView.rightButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.buttonView.rightButton addTarget:self
                                    action:@selector(showJoinForm)
                          forControlEvents:UIControlEventTouchUpInside
     ];
    
    [self.buttonView popIn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showLoginForm {
    [UIView animateWithDuration:.3 animations:^{
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
                                        self.tagLine.frame.origin.y + 300,
                                        self.tagLine.frame.size.width,
                                        self.tagLine.frame.size.height
                                        );
    } completion:^(BOOL finished){
    }];
    [self.buttonView popOut];
}

- (void)hideLoginForm {
    
}

- (void)showJoinForm {
    [self.buttonView popIn];
    
}

- (void)hideJoinForm {
    
}

@end
