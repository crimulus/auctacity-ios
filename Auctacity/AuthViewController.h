//
//  AuthViewController.h
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/10/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomButtonView.h"

@interface AuthViewController : UIViewController

@property (strong, nonatomic) IBOutlet BottomButtonView *buttonView;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UIImageView *shinyLip;
@property (strong, nonatomic) IBOutlet UITextView *tagLine;

@end
