//
//  AuctionSearchTableViewCell.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "AuctionSearchTableViewCell.h"

@implementation AuctionSearchTableViewCell

- (void)awakeFromNib {
    self.container = [[[NSBundle mainBundle] loadNibNamed:@"AuctionSearchTableViewCell" owner:self options:nil] objectAtIndex:0];
    [self addSubview:self.container];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
