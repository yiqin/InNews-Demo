//
//  ArticleBlock.m
//  InNews-Demo
//
//  Created by yiqin on 11/14/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleBlock.h"
#import "YQparse.h"

@implementation ArticleBlock

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentIndex = 0;
        
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text
{
    self = [self init];
    if (self) {
        _isText = YES;
        _text = text;
        _articleImage = nil;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)articleImage
{
    self = [self init];
    if (self) {
        _isText = NO;
        _text = nil;
        _articleImage = articleImage;
    }
    return self;
}

- (instancetype)initWithImageURL:(NSURL *)url
{
    self = [self init];
    if (self) {
        _isText = NO;
        _text = nil;
        [self loadImage:url];
    }
    return self;
}

- (void)loadImage:(NSURL *)url
{
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    
    YQHTTPRequestOperation *requestOperation = [[YQHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [YQImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Load image successfully.");
        // self.adImageView = [[UIImageView alloc] initWithImage:responseObject];
        self.articleImage = responseObject;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageIsReady" object:nil userInfo:@{@"currentIndex":[NSNumber numberWithInt:self.currentIndex]}];
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
        
    }];
    [requestOperation start];
}


@end
