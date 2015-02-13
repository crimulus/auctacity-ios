//
//  LoginFormView.h
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/12/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginFormView : UIView

@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (void)setDelegate:(id)delegate;

@end
