//
//  BottomButtonView.h
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/10/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomButtonView : UIView

@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (void)popIn;
- (void)popOut;

@end
