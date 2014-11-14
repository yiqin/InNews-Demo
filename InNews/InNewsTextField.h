//
//  InNewsTextField.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InNewsTextField : UIView

@property(strong, nonatomic) UIFont *font;
@property(strong, nonatomic) NSString* text;

- (void)addText:(NSString *)text;
- (void)setFont:(UIFont *)font;

+(UIFont *)getFont;

@end
