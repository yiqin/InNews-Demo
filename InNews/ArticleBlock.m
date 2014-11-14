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
        self.isText = YES;
    }
    return self;
}

- (void)setArticleImageView:(UIImageView *)articleImageView
{
    _articleImageView = articleImageView;
    self.isText = NO;
}

@end
