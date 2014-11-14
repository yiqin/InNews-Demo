//
//  Ad.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseObject.h"
#import "YQParse.h"

@interface Ad : YQParseObject

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject;

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) NSString *title;

@end
