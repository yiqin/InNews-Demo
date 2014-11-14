//
//  InNewsTextField.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "InNewsTextField.h"

@interface InNewsTextField()

@property(strong, nonatomic) UITableViewController *articleViewController;

@end


@implementation InNewsTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.articleViewController = [[UITableViewController alloc] initWithNibName:nil bundle:nil];
    }
    return self;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
