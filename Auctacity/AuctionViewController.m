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


@end
