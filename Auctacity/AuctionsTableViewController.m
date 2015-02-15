//
//  AuctionsTableViewController.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "AuctionsTableViewController.h"
#import "APIRequest.h"

@interface AuctionsTableViewController () {
    NSDictionary *sourceJSON;
}

@end

@implementation AuctionsTableViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    sourceJSON = [[APIRequest alloc] requestAtEndpoint:@"auction"];

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
    NSArray *matches = [sourceJSON objectForKey:@"matches"];
    return matches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auctionSearch" forIndexPath:indexPath];

    NSArray *matches = [sourceJSON objectForKey:@"matches"];
    NSDictionary *match = [matches objectAtIndex:indexPath.row];

    // Configure the cell ... (fetch the image on a background thread)
    [self performSelectorInBackground:@selector(fetchAuctionImage:) withObject:@[cell, match]];
    cell.imageView.image = [self resizeAuctionImage:[UIImage imageNamed:@"auction-no-photo.png"]];
    cell.textLabel.text = [match objectForKey:@"title"];

    return cell;
}

- (void)fetchAuctionImage:(NSArray *)args {
    UITableViewCell *cell = args[0];
    NSDictionary *match = args[1];
    NSURL *url = [NSURL URLWithString:[match objectForKey:@"imageUrl"]];
    NSLog(@"%@", url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self performSelectorOnMainThread:@selector(setAuctionImage:)
                           withObject:@[cell, data]
                        waitUntilDone:YES
     ];
}

- (void)setAuctionImage:(NSArray *)args {
    UITableViewCell *cell = args[0];
    NSData *data = args[1];
    cell.imageView.image = [self resizeAuctionImage:[UIImage imageWithData:data]];
}

- (UIImage *)resizeAuctionImage:(UIImage *)baseImage {
    CGSize newSize = CGSizeMake(300, 150);
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
    NSLog(@"Yes I fucking am: %@", sender);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
