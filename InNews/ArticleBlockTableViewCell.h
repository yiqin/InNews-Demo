//
//  ArticleBlockTableViewCell.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleBlock.h"

@interface ArticleBlockTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *articleImageView;
+ (CGFloat)cellHeight;
- (void)loadCell:(UIImageView *) imageView;


- (void) loadCellWithText:(NSString *)text;
+ (CGFloat)cellHeightWithText:(NSString *)text;






@end
