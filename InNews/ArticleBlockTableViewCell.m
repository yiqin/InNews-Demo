//
//  ArticleBlockTableViewCell.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleBlockTableViewCell.h"
#import "CocoaNewsTextView.h"
#import "CocoaNewsLabel.h"

@interface ArticleBlockTableViewCell()

@property(strong, nonatomic) CocoaNewsLabel *paragraphLabel;
@property (strong, nonatomic) UIImageView *articleImageView;

@property (strong, nonatomic) UIView *borderView;
@property (nonatomic) UIArticleStyle style;

@property (nonatomic) int colorIndicator;

@property (strong, nonatomic) UIColor *colorOne;
@property (strong, nonatomic) UIColor *colorTwo;

@end


@implementation ArticleBlockTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.backgroundColor = [UIColor redColor];
        self.colorIndicator = rand();
        
        if (self.colorIndicator%2 == 0) {
            self.colorOne = [UIColor colorWithRed:(140.0/255.0) green:(182.0/255.0) blue:(220.0/255.0) alpha:1];
            self.colorTwo = [UIColor colorWithRed:(66.0/255.0) green:(70.0/255.0) blue:(72.0/255.0) alpha:1.0];
        }
        else {
            self.colorOne = [UIColor colorWithRed:(236.0/255.0) green:(103.0/2550) blue:(120.0/255.0) alpha:1];
            self.colorTwo = [UIColor grayColor];
        }
        
        
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    self.paragraphLabel = [[CocoaNewsLabel alloc] initWithFrame:CGRectMake(5, 8, 300-10, 10)];
    [self addSubview:self.paragraphLabel];
    
    self.articleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 300-10, 148)];
    [self.articleImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:self.articleImageView];
    
    self.borderView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, 5, 10)];
    self.borderView.backgroundColor = self.colorOne;
    self.borderView.hidden = YES;
    [self addSubview:self.borderView];
}

- (void)loadCellWithText:(NSString *)text style:(UIArticleStyle)style
{
    self.articleImageView.hidden = YES;
    
    self.paragraphLabel.hidden = NO;
    switch (style) {
        case UIArticleStyleDefault:
            self.borderView.hidden = YES;
            [self.paragraphLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[CocoaNewsTextView getFont] text:text];
            self.paragraphLabel.textColor = [UIColor blackColor];
            break;
        case UIArticleStyleOne:
            self.borderView.hidden = NO;
            [self.paragraphLabel setFrame:CGRectMake(22, 8, 300-10-22, 10) font:[CocoaNewsTextView getFontTwo] text:text];
            // self.paragraphLabel.textColor = [UIColor grayColor];
            self.paragraphLabel.textColor = self.colorTwo;
            self.borderView.frame = CGRectMake(10, 8+2, 5, CGRectGetHeight(self.paragraphLabel.frame)-4);
            break;
        default:
            break;
    }
}

- (void)loadCellWithImage:(UIImage *)image
{
    self.articleImageView.hidden = NO;
    self.paragraphLabel.hidden = YES;
    self.borderView.hidden = YES;
    [self.articleImageView setImage:image];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithText:(NSString *)text style:(UIArticleStyle) style
{
    CocoaNewsLabel *cocoaNewsLabel = [[CocoaNewsLabel alloc] init];
    
    // [cocoaNewsLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[CocoaNewsTextField getFont] text:text];
    
    // [inNewsLabel updateFrameWithText:text];
    
    // NSLog(@"%f", CGRectGetHeight(cocoaNewsLabel.frame));
    
    switch (style) {
        case UIArticleStyleDefault:
            [cocoaNewsLabel setFrame:CGRectMake(5, 8, 300-10, 10) font:[CocoaNewsTextView getFont] text:text];
            break;
        case UIArticleStyleOne:
            [cocoaNewsLabel setFrame:CGRectMake(22, 8, 300-10-22, 10) font:[CocoaNewsTextView getFontTwo] text:text];
            break;
        default:
            break;
    }
    
    return CGRectGetHeight(cocoaNewsLabel.frame)+20;
}

- (void) loadCellWithArticleBlock:(ArticleBlock *)articleBlock
{
    // self.style = *(articleBlock.style);
    if (articleBlock.isText) {
        [self loadCellWithText:articleBlock.text style:articleBlock.style];
    }
    else {
        if (articleBlock.articleImage) {
            [self loadCellWithImage:articleBlock.articleImage];
        }
    }
}

+ (CGFloat)cellHeightWithArticleBlock:(ArticleBlock *)articleBlock
{
    if (articleBlock.isText) {
        return [ArticleBlockTableViewCell cellHeightWithText:articleBlock.text style:articleBlock.style];
    }
    else {
        return 140+8;
    }
}

@end
