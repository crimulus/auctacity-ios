//
//  AuctionsTableViewController.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "AuctionsTableViewController.h"
#import "APIRequest.h"
#import "AuctionViewController.h"

@interface AuctionsTableViewController () {
    NSDictionary *sourceJSON;
}

@end

@implementation AuctionsTableViewController {
    NSArray *matches;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    sourceJSON = [[APIRequest alloc] requestAtEndpoint:@"auction"];
    matches = [sourceJSON objectForKey:@"matches"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return matches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auctionSearch" forIndexPath:indexPath];
    NSDictionary *match = [matches objectAtIndex:indexPath.row];

    cell.imageView.image = [self resizeAuctionImage:[UIImage imageNamed:@"auction-no-photo.png"]];

    cell.textLabel.numberOfLines = 2;
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",
                           [match objectForKey:@"userIdx"],
                           [match objectForKey:@"title"],
                           nil
                           ];

    cell.detailTextLabel.numberOfLines = 5;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"\n\n%@ %@ %@, %@ %@\nEnds: %@",
                                 [match objectForKey:@"locationAddress1"],
                                 [match objectForKey:@"locationAddress2"],
                                 [match objectForKey:@"locationCity"],
                                 [match objectForKey:@"locationState"],
                                 [match objectForKey:@"locationPostalCode"],
                                 [match objectForKey:@"TS-BiddingEnd"],
                                 nil
                                 ];

    // Configure the cell ... (fetch the image on a background thread)
    [self performSelectorInBackground:@selector(fetchAuctionImage:) withObject:@[cell, match]];

    return cell;

}

- (void)fetchAuctionImage:(NSArray *)args {
    UITableViewCell *cell = args[0];
    NSDictionary *match = args[1];
    NSURL *url = [NSURL URLWithString:[match objectForKey:@"imageUrl"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [self resizeAuctionImage:[UIImage imageWithData:data]];
    dispatch_block_t block = ^{
        cell.imageView.image = image;
    };
    dispatch_async(dispatch_get_main_queue(), block);

}

- (UIImage *)resizeAuctionImage:(UIImage *)baseImage {
    return [self resizeAuctionImage:baseImage size:CGSizeMake(160, 80)];
}

- (UIImage *)resizeAuctionImage:(UIImage *)baseImage size:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [baseImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"auctionListToAuction"]) {
        AuctionViewController *avc = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        avc.auction = [matches objectAtIndex:path.row];
    }
}
@end
