//
//  APIRequest.m
//  Auctacity
//
//  Created by Tharp, Jeremy on 2/14/15.
//  Copyright (c) 2015 Tharp, Jeremy. All rights reserved.
//

#import "APIRequest.h"
#import <Security/Security.h>
#import "UICKeyChainStore.h"

@implementation APIRequest {
    UICKeyChainStore *_kc;
    NSString *username;
    NSString *password;
}

- (NSDictionary *)requestAtEndpoint:(NSString *)endpoint {

    [self getCredentials];

    NSString *urlStr = [NSString stringWithFormat:@"https://%@:%@@www.auctacity.com/rest/%@/",
                        [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                        [password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                        endpoint
                        ];
    NSLog(@"%@", urlStr);
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSError *error;
    NSHTTPURLResponse *response;

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];

    if (!error) {
        NSMutableDictionary *json = [NSJSONSerialization
                                     JSONObjectWithData:data
                                     options:NSJSONReadingMutableContainers
                                     error:&error
                                     ];
        if (!error) { return json; }
    }

    return @{ @"error" : [NSString stringWithFormat:@"%@", error.localizedDescription] };

}
- (NSDictionary *)requestAtEndpoint:(NSString *)endpoint username:(NSString *)u password:(NSString *)p {
    //    username = u;   // For simulator
    //    password = p;   // For simulator
    if (u != nil && p != nil) {
        [self saveCredentials:u password:p];
    }
    return [self requestAtEndpoint:endpoint];
}

- (void)saveCredentials:(NSString *)u password:(NSString *)p {
    UICKeyChainStore *kc = [self keychain];
    [kc setString:u forKey:@"username"];
    [kc setString:p forKey:@"password"];
}

- (void)clearCredentials {
    UICKeyChainStore *kc = [self keychain];
    [kc removeItemForKey:@"username"];
    [kc removeItemForKey:@"password"];
}

- (void)getCredentials {
    UICKeyChainStore *kc = [self keychain];
    username = [kc stringForKey:@"username"];
    NSLog(@"GC: %@", username);
    password = [kc stringForKey:@"password"];
}

- (BOOL)loggedIn {
    [self getCredentials];
    return (username != nil && password != nil);
}

- (void)logOut {
    [self clearCredentials];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessfulLogout" object:nil userInfo:nil];
}

- (UICKeyChainStore *)keychain {
    if (!_kc) {
        _kc = [UICKeyChainStore keyChainStore];
    }
    return _kc;
}

@end

