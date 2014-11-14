//
//  InNewsTextField.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "InNewsTextField.h"
#import "ArticleTableViewController.h"

@interface InNewsTextField()

@property(strong, nonatomic) ArticleTableViewController *articleTVC;
@property(strong, nonatomic) NSMutableDictionary *blocks;
@property(nonatomic) int currentIndex;

@end


@implementation InNewsTextField


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
    }
    return self;
}

-(void)addText:(NSString *)text
{
    
    [self.blocks setObject:text forKey: [NSNumber numberWithInt:self.currentIndex]];
    self.currentIndex++;
    // NSLog(@"%@", self.blocks);
    
    self.articleTVC.blocks = self.blocks;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
