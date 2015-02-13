//
//  LoginFormView.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/12/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "LoginFormView.h"

@implementation LoginFormView

- (void)awakeFromNib {
    [[[NSBundle mainBundle] loadNibNamed:@"LoginFormView" owner:self options:nil] objectAtIndex:0];
    [self addSubview: self.container];

    [self.username setKeyboardType:UIKeyboardTypeEmailAddress];
}

- (void)setDelegate:(id)delegate {
    self.username.delegate = delegate;
    self.password.delegate = delegate;
}

@end
