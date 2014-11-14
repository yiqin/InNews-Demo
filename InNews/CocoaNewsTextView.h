//
//  InNewsTextField.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleBlock.h"

@interface CocoaNewsTextView : UIView

@property(strong, nonatomic) UIFont *font;
@property(strong, nonatomic) NSString* text;


- (void)addImage:(NSURL *)url;

- (void)addText:(NSString *)text;
- (void)addText:(NSString *)text style:(UIArticleStyle) style;

- (void)setFont:(UIFont *)font;

+(UIFont *)getFont;
+(UIFont *)getFontTwo;

@end
