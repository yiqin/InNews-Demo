//
//  AdTableViewCell.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "AdTableViewCell.h"

@implementation AdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.backgroundColor = [UIColor lightGrayColor];
        [self setSubviews];
        
    }
    return self;
}

- (void)setSubviews
{
    // self.adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    // [self.adImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    self.adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 300-10, 148)];
    [self.adImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.cellScrollView addSubview:self.adImageView];
}

- (void)loadCell:(Ad *) ad
{
    self.adImageView.image = ad.adImageView.image;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 140+8;
}

@end
