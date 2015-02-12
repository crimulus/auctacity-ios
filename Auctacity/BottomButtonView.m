//
//  Bottomcontainer.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/10/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "BottomButtonView.h"

@implementation BottomButtonView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)awakeFromNib {
    self.container = [[[NSBundle mainBundle] loadNibNamed:@"BottomButtonView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:self.container];
}

- (void)popIn {

    CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.container.transform = transform;
    
    self.container.frame = CGRectMake(
                                      self.container.frame.origin.x,
                                      self.container.frame.origin.y + 4000,
                                      self.container.frame.size.width,
                                      self.container.frame.size.height
                                      );

    [UIView animateWithDuration:1 animations:^{

        self.container.frame = CGRectMake(
                                          self.container.frame.origin.x,
                                          self.container.frame.origin.y - 4025,
                                          self.container.frame.size.width,
                                          self.container.frame.size.height
                                          );
    } completion:^(BOOL finished){
        [UIView animateWithDuration:.25 animations:^{

            CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
            self.container.transform = transform;
            
            self.container.frame = CGRectMake(
                                              self.container.frame.origin.x,
                                              self.container.frame.origin.y + 35,
                                              self.container.frame.size.width,
                                              self.container.frame.size.height
                                              );
        } completion:^(BOOL finished){
            [UIView animateWithDuration:.1 animations:^{
                self.container.frame = CGRectMake(
                                                  self.container.frame.origin.x,
                                                  self.container.frame.origin.y - 10,
                                                  self.container.frame.size.width,
                                                  self.container.frame.size.height
                                                  );
            } completion:^(BOOL finished){
            }];
        }];
    }];
    
}

- (void)popOut {
    
    [UIView animateWithDuration:.1 animations:^{
        self.container.frame = CGRectMake(
                                          self.container.frame.origin.x,
                                          self.container.frame.origin.y + 10,
                                          self.container.frame.size.width,
                                          self.container.frame.size.height
                                          );
    } completion:^(BOOL finished){
        [UIView animateWithDuration:.25 animations:^{

            CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.container.transform = transform;
            
            self.container.frame = CGRectMake(
                                              self.container.frame.origin.x,
                                              self.container.frame.origin.y - 35,
                                              self.container.frame.size.width,
                                              self.container.frame.size.height
                                              );
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1 animations:^{
                self.container.frame = CGRectMake(
                                                  self.container.frame.origin.x,
                                                  self.container.frame.origin.y + 4025,
                                                  self.container.frame.size.width,
                                                  self.container.frame.size.height
                                                  );
            } completion:^(BOOL finished){
                self.container.alpha = 0;
                self.container.frame = CGRectMake(
                                                  self.container.frame.origin.x,
                                                  self.container.frame.origin.y - 4000,
                                                  self.container.frame.size.width,
                                                  self.container.frame.size.height
                                                  );
                [UIView animateWithDuration:2.5 animations:^{
                    self.container.alpha = 1;
                    CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
                    self.container.transform = transform;
                } completion:^(BOOL finished){
                }];
            }];
        }];
    }];
    
}

@end
