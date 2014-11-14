//
//  Ad.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "Ad.h"


@implementation Ad

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject
{
    self = [super initWithClassName:parseObject.parseClassName];
    if (self) {
        // Copy the parseObject behaviour.
        self.objectId = parseObject.objectId;
        self.createdAt = parseObject.createdAt;
        self.updatedAt = parseObject.updatedAt;
        self.responseJSON = parseObject.responseJSON;
        
        self.title = [self.responseJSON objectForKey:@"title"];
        
        NSDictionary *imageFileDictionary = [self.responseJSON objectForKey:@"image"];
        
        self.imageURL = [[NSURL alloc] initWithString:[imageFileDictionary objectForKey:@"url"]];
        
    }
    return self;
}

- (void)setImageURL:(NSURL *)imageURL
{
    if (imageURL) {
        _imageURL =imageURL;
        
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:imageURL];
        
        YQHTTPRequestOperation *requestOperation = [[YQHTTPRequestOperation alloc] initWithRequest:urlRequest];
        requestOperation.responseSerializer = [YQImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(YQHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Load image successfully.");
            self.adImageView = [[UIImageView alloc] initWithImage:responseObject];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AdIsReady" object:nil];
            
            
        } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
            
        }];
        [requestOperation start];
    }
}

@end
