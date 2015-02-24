//
//  LoginFormView.h
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/12/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIRequest.h"

@interface LoginFormView : UIView <UITextFieldDelegate>

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (void)setDelegates:(id)delegate;
- (void)logIn;
- (IBAction)loginButtonPressed:(id)sender;

@end
