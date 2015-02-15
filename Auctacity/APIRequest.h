//
//  APIRequest.h
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequest : NSObject

- (NSDictionary *)requestAtEndpoint:(NSString *)endpoint;
- (NSDictionary *)requestAtEndpoint:(NSString *)endpoint username:(NSString *)u password:(NSString *)p;

- (BOOL)loggedIn;
- (void)logOut;

@end
