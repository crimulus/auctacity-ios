//
//  LoginFormView.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/12/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "LoginFormView.h"

@implementation LoginFormView

- (void)viewDidLoad {
}
- (void)awakeFromNib {

    [[[NSBundle mainBundle] loadNibNamed:@"LoginFormView" owner:self options:nil] objectAtIndex:0];
    [self addSubview: self.container];

    [self.username setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.username addTarget:self action:@selector(validate) forControlEvents:UIControlEventEditingChanged];

    [self.password addTarget:self action:@selector(validate) forControlEvents:UIControlEventEditingChanged];

    [self setDelegates:self];

}

- (void)setDelegates:(id)delegate {
    self.username.delegate = delegate;
    self.password.delegate = delegate;
}

- (BOOL)validate {
    return [self validate:([self.username isFirstResponder] ? @"username" : @"password")];
}

- (BOOL)validate:(NSString *)field {

    UILabel *label;
    NSString *value;
    BOOL valid;

    if ([field isEqualToString:@"username"]) {
        value = [self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        label = self.usernameLabel;
    }

    else if ([field isEqualToString:@"password"]) {
        value = self.password.text;
        label = self.passwordLabel;
    }

    valid = ![value isEqualToString:@""];
    label.textColor = !valid ? [UIColor redColor] : [UIColor blackColor];
    NSString *fontName = !valid ? @"HelveticaNeue-Bold" : @"HelveticaNeue-Light";
    [label setFont:[UIFont fontWithName:fontName size:label.font.pointSize]];

    return valid;

}

- (void)logIn {

    NSDictionary *json;

    if (![self.username.text isEqualToString:@""]) {
        json = [[APIRequest alloc] requestAtEndpoint:@"user"
                                            username:self.username.text
                                            password:self.password.text
                ];
    }
    else {
        json = [[APIRequest alloc] requestAtEndpoint:@"user"];
    }

    NSString *message = [json objectForKey:@"error"];
    if (message) {
        if ([[json objectForKey:@"code"] isEqualToString:@"-1012"]) { // Bad login
            message = @"Invalid username/password";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
                                                        message:message
                                                       delegate:self.viewController
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil
                              ];
        [alert show];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessfulLogin" object:nil userInfo:json];
    }

}

- (IBAction)loginButtonPressed:(id)sender {
    BOOL valid = YES;
    valid = [self validate:@"username"] && valid;
    valid = [self validate:@"password"] && valid;
    if (valid) { [self logIn]; }
}


@end
