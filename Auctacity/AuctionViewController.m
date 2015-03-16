//
//  AuctionViewController.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "AuctionViewController.h"
#import "BottomButtonView.h"
#import "LotViewController.h"
#import "LotsTableViewController.h"

@interface AuctionViewController ()
@end

@implementation AuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.auction) {

        self.name.text = [self.auction objectForKey:@"title"];
        self.seller.text = [self.auction objectForKey:@"userIdx"];

        NSString *descText = [self.auction objectForKey:@"description"];
        self.desc.frame = CGRectMake(self.desc.frame.origin.x,
                                     self.desc.frame.origin.y,
                                     self.desc.frame.size.width,
                                     [self labelHeight:descText label:self.desc]
                                     );
        self.desc.text = [self.auction objectForKey:@"description"];

        [self.detailsScrollView setScrollEnabled:YES];
        [self.detailsScrollView setContentSize:CGSizeMake(
                                                          self.view.frame.size.width,
                                                          self.desc.frame.origin.y + [self labelHeight:self.desc.text label:self.desc] + 400
                                                          )
         ];

        [self performSelectorInBackground:@selector(fetchAuctionImage) withObject:nil];

        // Buttons -- to be expanded later
        [self.buttonView.leftButton setTitle:@"Subscribe" forState:UIControlStateNormal];
        [self.buttonView.leftButton addTarget:self
                                       action:@selector(subscribe)
                             forControlEvents:UIControlEventTouchUpInside
         ];

        [self.buttonView.rightButton setTitle:@"View Lots" forState:UIControlStateNormal];
        [self.buttonView.rightButton addTarget:self
                                        action:@selector(showAuctionLotList)
                              forControlEvents:UIControlEventTouchUpInside
         ];
        [self.buttonView popIn];
    }
    else {
        // Alert view? Will this ever happen?
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)subscribe {
    NSString *message = @"I have read and fully understand all of the terms of this auction.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auction Subscription (1/7)"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes, I Fully Understand", nil
                          ];
    [alert show];
}
- (void)fetchAuctionImage {
    NSURL *url = [NSURL URLWithString:[self.auction objectForKey:@"imageUrl"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self performSelectorOnMainThread:@selector(setAuctionImage:)
                           withObject:data
                        waitUntilDone:NO
     ];
}

- (void)showAuctionLotList {
    LotsTableViewController *ltvc = [[LotsTableViewController alloc] init];
    ltvc.searchParams = [NSString stringWithFormat:@"auctionIdx=%@",
                         [self.auction objectForKey:@"idx"]
                         ];
    [self.navigationController pushViewController:ltvc animated:YES];
    NSLog(@"asldfkjas");
}

- (void)setAuctionImage:(NSData *)data {
    self.image.image = [self resizeAuctionImage:[UIImage imageWithData:data]];
}

- (UIImage *)resizeAuctionImage:(UIImage *)baseImage {
    CGSize newSize = CGSizeMake(320, 160);
    UIGraphicsBeginImageContext(newSize);
    [baseImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGFloat)labelHeight:(NSString *)labelText label:(UILabel *)label {
    CGRect expectedLabelSize = [labelText boundingRectWithSize:CGSizeMake((int)label.frame.size.width, 5000)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{
                                                                 NSFontAttributeName: label.font
                                                                 }
                                                       context:nil
                                ];
    return expectedLabelSize.size.height;
}

/**********************************
 ** UIAlertView DELEGATE METHODS **
 *********************************/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%@", alertView.title);
    if ([alertView.title isEqualToString:@"Auction Subscription (7/7)"]) {

    }
    else if (buttonIndex == 1) {
        NSString *message;
        NSString *title;
        NSString *action = @"I understand";
        if ([alertView.title isEqualToString:@"Auction Subscription (1/7)"]) {
            title = @"Auction Subscription (2/7)";
            message = [NSString stringWithFormat:@"I am subscribing to an auction posted by %@.", [self.auction objectForKey:@"publicName"]];
        }
        else if ([alertView.title isEqualToString:@"Auction Subscription (2/7)"]) {
            title = @"Auction Subscription (3/7)";
            message = [NSString stringWithFormat:@"I must pick up my items in %@, %@ on the specified pickup dates, or I forfeit them WITHOUT refund (unless otherwise stated).",
                       [self.auction objectForKey:@"locationCity"],
                       [self.auction objectForKey:@"locationState"],
                       nil
                       ];
        }
        else if ([alertView.title isEqualToString:@"Auction Subscription (3/7)"]) {
            title = @"Auction Subscription (4/7)";
            NSLog(@"%@", self.auction);
            message = [NSString stringWithFormat:@"Items I bid on are subject to a buyers premium of %@%% and sales tax of %@%% of my winning bids.",
                       [self.auction objectForKey:@"buyersPremium"],
                       [self.auction objectForKey:@"salesTax"],
                       nil
                       ];
        }
        else if ([alertView.title isEqualToString:@"Auction Subscription (4/7)"]) {
            title = @"Auction Subscription (5/7)";
            message = [NSString stringWithFormat:@"Lots in this auction are staggered to end every %@ seconds starting at the auction bidding end date and time.",
                       [self.auction objectForKey:@"lotSeparationSeconds"],
                       nil
                       ];
        }
        else if ([alertView.title isEqualToString:@"Auction Subscription (5/7)"]) {
            title = @"Auction Subscription (6/7)";
            message = [NSString stringWithFormat:@"Bids placed on any lot within %@ of its closing time will extend the bidding window of that lot by %@.",
                       [self.auction objectForKey:@"bidExtensionRange"],
                       [self.auction objectForKey:@"bidExtensionLength"],
                       nil
                       ];
        }
        else if ([alertView.title isEqualToString:@"Auction Subscription (6/7)"]) {
            title = @"Auction Subscription (7/7)";
            message = @"I am expected to have a valid credit card on file with enough of a balance on it to pay for my winnings, or I could be banned from Auctacity.";
            action = @"Subscribe me!";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:action, nil
                              ];
        [alert show];

    }
}
@end
