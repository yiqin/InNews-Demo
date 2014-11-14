//
//  ArticleBlock.m
//  InNews-Demo
//
//  Created by yiqin on 11/14/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleBlock.h"

@implementation ArticleBlock

- (instancetype)init
{
    self = [super init];
    if (self) {
        
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

@end
