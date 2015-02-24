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

        self.detailsScrollView.contentSize = CGSizeMake(
                                                        self.detailsScrollView.frame.size.width,
                                                        1500
                                                        );
        [self.detailsScrollView setScrollEnabled:YES];

        self.name.text = [self.auction objectForKey:@"title"];
        self.seller.text = [self.auction objectForKey:@"userIdx"];

        NSString *descText = [self.auction objectForKey:@"description"];
        self.desc.frame = CGRectMake(self.desc.frame.origin.x,
                                     self.desc.frame.origin.y,
                                     self.desc.frame.size.width,
                                     [self labelHeight:descText label:self.desc]
                                     );

        self.desc.numberOfLines = 0;
        self.desc.lineBreakMode = NSLineBreakByWordWrapping;
        self.desc.text = descText;

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

- (CGFloat)labelHeight:(NSString *)labelText label:(UILabel *)label {
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"font", label.font,
                                          nil];
    CGRect expectedLabelSize = [labelText boundingRectWithSize:CGSizeMake(label.frame.size.width, 50000)
                                                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                    attributes:attributesDictionary
                                                       context:nil
                                ];
    return expectedLabelSize.size.height*10;
}

@end
