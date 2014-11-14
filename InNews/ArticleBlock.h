//
//  ArticleBlock.h
//  InNews-Demo
//
//  Created by yiqin on 11/14/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ArticleBlock : NSObject

@property(nonatomic) BOOL isText;
@property(strong, nonatomic) NSString* text;
@property (strong, nonatomic) UIImageView *articleImageView;


@end
