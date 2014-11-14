//
//  ArticleTableViewController.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleTableViewController.h"
#import "ArticleBlockTableViewCell.h"
#import "AdTableViewCell.h"

#import "YQNetworking.h"

@interface ArticleTableViewController ()

@property(nonatomic) BOOL hasAd;
@property(nonatomic) int adPosition;
@property(strong, nonatomic) NSMutableString *wholeArticle;

@property(nonatomic) BOOL firstTimeLoad;

@end

@implementation ArticleTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // self.view.backgroundColor = [UIColor yellowColor];
        self.tableView.separatorColor = [UIColor clearColor];
        
        self.blocks = [[NSMutableDictionary alloc] init];
        self.wholeArticle = [[NSMutableString alloc] init];
        self.adPosition = 2;
        
        // Change it later.
        self.hasAd = YES;
        
        
        self.firstTimeLoad = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidLayoutSubviews
{
    if (self.firstTimeLoad) {
        [self.wholeArticle setString:@""];
        
        NSArray *keys = [self.blocks allKeys];
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
        NSArray *sortKeys = [keys sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        
        NSLog(@"%@", sortKeys);
        
        for (int i=0; i<[sortKeys count]; i++) {
            [self.wholeArticle appendString: [self.blocks objectForKey:[sortKeys objectAtIndex:i]]];
        }
        NSLog(@"%@", self.wholeArticle);
        
        
        
        [self doTextAnalytics:self.wholeArticle];
        
        
        self.firstTimeLoad = NO;
    }
}

- (void)doTextAnalytics:(NSString *)text
{
    YQHTTPRequestOperationManager *manager = [YQHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"text": text};
    
    manager.requestSerializer = [YQJSONRequestSerializer serializer];
    manager.responseSerializer = [YQJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"xiL7zSTisvmshlzqU2b8HimW98NFp1MvblHjsnGVIXnFab2CzB" forHTTPHeaderField:@"X-Mashape-Key"];
    
    [manager GET:@"https://aylien-text.p.mashape.com/hashtags" parameters:params success:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBlocks:(NSMutableDictionary *)blocks
{
    _blocks = blocks;

    
    // No need to reload.
    // [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.hasAd) {
        return [self.blocks count]+1;
    }
    else {
        return [self.blocks count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.adPosition) {
        return [AdTableViewCell cellHeight];
    }
    else {
        NSString *tempText = [self.blocks objectForKey:[NSNumber numberWithInt:indexPath.row]];
        return [ArticleBlockTableViewCell cellHeightWithText:tempText];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString static *articleCellIdentifier = @"ArticleCellIdentifier";
    NSString static *adCellIdentifier = @"AdCellIdentifier";
    
    if (indexPath.row == self.adPosition) {
        AdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCellIdentifier];
        if (cell == nil) {
            cell = [[AdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    else {
        ArticleBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCellIdentifier];
        if (cell == nil) {
            cell = [[ArticleBlockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:articleCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        // Configure the cell...
        NSString *tempText = [self.blocks objectForKey:[NSNumber numberWithInt:indexPath.row]];
        [cell loadCellWithText:tempText];
        return cell;
    }
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
