//
//  AuctionViewController.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "AuctionViewController.h"
#import "BottomButtonView.h"

@interface AuctionViewController ()
@end

@implementation AuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.auction) {
        self.seller.text = [self.auction objectForKey:@"userIdx"];
        [self performSelectorInBackground:@selector(fetchAuctionImage) withObject:nil];

        // Buttons -- to be expanded later
        [self.buttonView.leftButton setTitle:@"Subscribe" forState:UIControlStateNormal];
        [self.buttonView.leftButton addTarget:self
                                       action:@selector(subscribe)
                             forControlEvents:UIControlEventTouchUpInside
         ];

        [self.buttonView.rightButton setTitle:@"View Lots" forState:UIControlStateNormal];
        [self.buttonView.rightButton addTarget:self
                                        action:@selector(viewLots)
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

- (void)viewLots {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"View Lots"
                                                    message:@"Eventually, this will work"
                                                   delegate:nil
                                          cancelButtonTitle:@"Awww :("
                                          otherButtonTitles:nil
                          ];
    [alert show];
}

- (void)subscribe {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Subscribe!!!"
                                                    message:@"Eventually, this will work"
                                                   delegate:nil
                                          cancelButtonTitle:@"Good to know"
                                          otherButtonTitles:nil
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


@end
