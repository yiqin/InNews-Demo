//
//  AdTableViewCell.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *adImageView;

+ (CGFloat)cellHeight;

@end