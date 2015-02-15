//
//  AuctionViewController.h
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuctionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *sellerLabel;
@property (strong, nonatomic) IBOutlet UILabel *seller;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *distance;

@property (strong, nonatomic) IBOutlet UILabel *inspectionLabel;
@property (strong, nonatomic) IBOutlet UILabel *inspection;

@property (strong, nonatomic) IBOutlet UILabel *biddingLabel;
@property (strong, nonatomic) IBOutlet UILabel *bidding;

@property (strong, nonatomic) IBOutlet UILabel *pickupLabel;
@property (strong, nonatomic) IBOutlet UILabel *pickup;

@property (strong, nonatomic) IBOutlet UILabel *buyersPremiumLabel;
@property (strong, nonatomic) IBOutlet UILabel *buyersPremium;

@property (strong, nonatomic) IBOutlet UILabel *salesTaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *salesTax;

@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UILabel *desc;



@end
