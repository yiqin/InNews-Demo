//
//  ArticleBlock.h
//  InNews-Demo
//
//  Created by yiqin on 11/14/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    UIArticleStyleDefault,
    UIArticleStyleOne,
} UIArticleStyle;

@interface ArticleBlock : NSObject

- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithImage:(UIImage *)articleImage;
- (instancetype)initWithImageURL:(NSURL *)url;

@property(nonatomic) BOOL isText;
@property(strong, nonatomic) NSString* text;
@property (strong, nonatomic) UIImage *articleImage;

@property (nonatomic) int currentIndex;

@property (nonatomic) UIArticleStyle style;

@end
