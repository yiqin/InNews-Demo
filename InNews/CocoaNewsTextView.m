//
//  InNewsTextField.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "CocoaNewsTextView.h"
#import "ArticleTableViewController.h"
#import "ArticleBlock.h"
#import "YQParse.h"

@interface CocoaNewsTextView()

@property(strong, nonatomic) ArticleTableViewController *articleTVC;
@property(strong, nonatomic) NSMutableDictionary *blocks;
@property(nonatomic) int currentIndex;

@end


@implementation CocoaNewsTextView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentIndex = 0;
        self.blocks = [[NSMutableDictionary alloc] init];
        
        self.backgroundColor = [UIColor redColor];
        self.articleTVC = [[ArticleTableViewController alloc] initWithNibName:nil bundle:nil];
        self.articleTVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [self addSubview:self.articleTVC.view];
        
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)addImage:(NSURL *)url
{
    ArticleBlock *articleBlock = [[ArticleBlock alloc] initWithImageURL:url];
    [self.blocks setObject:articleBlock forKey: [NSNumber numberWithInt:self.currentIndex]];
    articleBlock.currentIndex = self.currentIndex;
    self.currentIndex++;
    self.articleTVC.blocks = self.blocks;
}

-(void)addText:(NSString *)text
{
    NSArray *blockItems = [text componentsSeparatedByString:@"\n\n"];
    
    for (NSString*blockItem in blockItems) {
        
        ArticleBlock *articleBlock = [[ArticleBlock alloc] initWithText:blockItem];
        articleBlock.style = UIArticleStyleDefault;
        [self.blocks setObject:articleBlock forKey: [NSNumber numberWithInt:self.currentIndex]];
        articleBlock.currentIndex = self.currentIndex;
        self.currentIndex++;
    }
    // NSLog(@"%@", self.blocks);
    
    self.articleTVC.blocks = self.blocks;
}

- (void)addText:(NSString *)text style:(UIArticleStyle) style
{
    NSArray *blockItems = [text componentsSeparatedByString:@"\n\n"];
    
    for (NSString*blockItem in blockItems) {
        
        ArticleBlock *articleBlock = [[ArticleBlock alloc] initWithText:blockItem];
        articleBlock.style = style;
        [self.blocks setObject:articleBlock forKey: [NSNumber numberWithInt:self.currentIndex]];
        articleBlock.currentIndex = self.currentIndex;
        self.currentIndex++;
    }
    // NSLog(@"%@", self.blocks);
    
    self.articleTVC.blocks = self.blocks;
}

-(void)setText:(NSString *)text
{
    _text = text;
    [self addText:text];
}

-(void)setFont:(UIFont *)font
{
    _font = font;
}

+(UIFont *)getFont
{
    return [UIFont systemFontOfSize:16];
}

+(UIFont *)getFontTwo
{
    return [UIFont italicSystemFontOfSize:14.0f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
