//
//  ArticleTableViewController.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ArticleTableViewController : UITableViewController <SWTableViewCellDelegate>


@property(strong, nonatomic) NSMutableDictionary *blocks;


@end
