//
//  AdTableViewCell.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ad.h"
#import "SWTableViewCell.h"

@interface AdTableViewCell : SWTableViewCell

@property (strong, nonatomic) UIImageView *adImageView;

- (void)loadCell:(Ad *) ad;

+ (CGFloat)cellHeight;


@end
