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
        // self.backgroundColor = [UIColor redColor];
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    self.paragraphLabel = [[InNewsLabel alloc] initWithFrame:CGRectMake(5, 8, 300-10, 10)];
    [self addSubview:self.paragraphLabel];
}

- (void)loadCellWithText:(NSString *)text
{
    [self.paragraphLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[UIFont systemFontOfSize:16] text:text];
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
    InNewsLabel *inNewsLabel = [[InNewsLabel alloc] init];
    
    [inNewsLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[UIFont systemFontOfSize:16] text:text];
    
    // [inNewsLabel updateFrameWithText:text];
    
    NSLog(@"%f", CGRectGetHeight(inNewsLabel.frame));
    
    return CGRectGetHeight(inNewsLabel.frame)+20;
}

@end
