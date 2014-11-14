//
//  ArticleBlockTableViewCell.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleBlockTableViewCell.h"
#import "InNewsLabel.h"

@interface ArticleBlockTableViewCell()

@property(strong, nonatomic) InNewsLabel *paragraphLabel;

@end


@implementation ArticleBlockTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    self.paragraphLabel = [[InNewsLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
}

- (void)loadCellWithText:(NSString *)text
{
    [self.paragraphLabel updateFrameWithText:text];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithText:(NSString *)text
{
    InNewsLabel *inNewsLabel = [[InNewsLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    [inNewsLabel updateFrameWithText:text];
    
    return CGRectGetHeight(inNewsLabel.frame);
}

@end
