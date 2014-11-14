//
//  ArticleBlockTableViewCell.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleBlockTableViewCell.h"
#import "CocoaNewsTextField.h"
#import "CocoaNewsLabel.h"

@interface ArticleBlockTableViewCell()

@property(strong, nonatomic) CocoaNewsLabel *paragraphLabel;

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
    self.paragraphLabel = [[CocoaNewsLabel alloc] initWithFrame:CGRectMake(5, 8, 300-10, 10)];
    [self addSubview:self.paragraphLabel];
}

- (void)loadCellWithText:(NSString *)text
{
    [self.paragraphLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[CocoaNewsTextField getFont] text:text];
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
    CocoaNewsLabel *cocoaNewsLabel = [[CocoaNewsLabel alloc] init];
    
    [cocoaNewsLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[CocoaNewsTextField getFont] text:text];
    
    // [inNewsLabel updateFrameWithText:text];
    
    NSLog(@"%f", CGRectGetHeight(cocoaNewsLabel.frame));
    
    return CGRectGetHeight(cocoaNewsLabel.frame)+20;
}

@end
