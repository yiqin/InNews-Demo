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
#import "YQParse.h"

#import "Ad.h"

@interface ArticleTableViewController ()

@property(nonatomic) BOOL hasAd;
@property(nonatomic) int adPosition;


@property(nonatomic, strong) Ad *ad;


@property(strong, nonatomic) NSMutableString *wholeArticle;

@property(nonatomic) BOOL firstTimeLoad;

@end

@implementation ArticleTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginToInsertAd) name:@"AdIsReady" object:nil];
        
        // self.view.backgroundColor = [UIColor yellowColor];
        self.tableView.separatorColor = [UIColor clearColor];
        
        
        self.blocks = [[NSMutableDictionary alloc] init];
        self.wholeArticle = [[NSMutableString alloc] init];
        self.adPosition = 2;
        
        // Change it later.
        self.hasAd = NO;
        
        
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

// viewDidAppear didn't work. So I put it here.
- (void)viewDidLayoutSubviews
{
    if (self.firstTimeLoad) {
        [self.wholeArticle setString:@""];
        
        NSArray *keys = [self.blocks allKeys];
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
        NSArray *sortKeys = [keys sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        
        NSLog(@"%@", sortKeys);
        
        for (int i=0; i<[sortKeys count]; i++) {
            ArticleBlock *block = [self.blocks objectForKey:[sortKeys objectAtIndex:i]];
            if (block.isText) {
                [self.wholeArticle appendString: block.text];
            }
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
        [self parseTextAnaltyicsResult:responseObject];
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

/*!
 Multiply hashtags.
 */
- (void)parseTextAnaltyicsResult:(NSDictionary *) results
{
    NSArray *hashtagsResults = [results objectForKey:@"hashtags"];
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"Keywords"];
    [query whereKey:@"string" containedIn:hashtagsResults];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects count]>0) {
                int r = rand() % [objects count];
                // Pick the first one now.
                YQParseObject *object = [objects objectAtIndex:r];
                NSLog(@"objectId - %@", object.objectId);
                
                NSDictionary *belongTo = [object.responseJSON objectForKey:@"belongTo"];
                NSString *adObjectId = [belongTo objectForKey:@"objectId"];
                [self loadAdImageWithObjectId:adObjectId];
            }
        }
    }];
}

-(void)loadAdImageWithObjectId:(NSString *) objectId
{
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"Ads"];
    [query getObjectInBackgroundWithId:objectId block:^(YQParseObject *object, NSError *error) {
        if (!error) {
            self.ad = [[Ad alloc] initWithYQParseObject:object];
        }
    }];
}

- (void)beginToInsertAd
{
    self.hasAd = YES;
    
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:self.adPosition inSection:0]; //ALSO TRIED WITH indexPathRow:0
    NSArray *indexArray = [NSArray arrayWithObjects:path1,nil];
    
    [self.tableView beginUpdates];
    
    [YQParseAnalytics trackEvent:@"Impressions" dimensions:@{@"Advertiser":self.ad.title}];
    
    [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
}

- (void)deleteAdFromTableView
{
    self.hasAd = NO;
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:self.adPosition inSection:0]; //ALSO TRIED WITH indexPathRow:0
    NSArray *indexArray = [NSArray arrayWithObjects:path1,nil];
    [self.tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
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
    if ((indexPath.row == self.adPosition) && (self.hasAd == YES)) {
        return [AdTableViewCell cellHeight];
    }
    else {
        int blockIndex = [self getBlockIndex:indexPath.row];
        ArticleBlock *temp = [self.blocks objectForKey:[NSNumber numberWithInt:blockIndex]];
        
        return [ArticleBlockTableViewCell cellHeightWithArticleBlock:temp];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString static *articleCellIdentifier = @"ArticleCellIdentifier";
    NSString static *adCellIdentifier = @"AdCellIdentifier";
    
    NSLog(@"%i", indexPath.row);
    
    if ((indexPath.row == self.adPosition) && (self.hasAd == YES)) {
        
        AdTableViewCell *cell = (AdTableViewCell *)[tableView dequeueReusableCellWithIdentifier:adCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[AdTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:adCellIdentifier];
            
            cell.leftUtilityButtons = [self leftButtons];
            cell.rightUtilityButtons = [self rightButtons];
            cell.delegate = self;
        }
        
        
        cell.textLabel.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.text = @"Some detail text";
        
        
        [cell loadCell:self.ad];
        return cell;
        
    }
    else {
        int blockIndex = [self getBlockIndex:indexPath.row];
        
        ArticleBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCellIdentifier];
        if (cell == nil) {
            cell = [[ArticleBlockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:articleCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        // Configure the cell...
        
        ArticleBlock *temp = [self.blocks objectForKey:[NSNumber numberWithInt:blockIndex]];
        
        
        [cell loadCellWithArticleBlock:temp];
        
        return cell;
        
    }
}

- (int) getBlockIndex:(int)currentIndexRow
{
    int blockIndex;
    
    if (self.hasAd) {
        if(currentIndexRow <= self.adPosition){
            blockIndex = currentIndexRow;
        }
        else {
            blockIndex = currentIndexRow-1;
        }
    }
    else {
        blockIndex = currentIndexRow;
    }

    return blockIndex;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@""];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    /*
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    */
    return leftUtilityButtons;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            [self deleteAdFromTableView];
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            // [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            self.hasAd = NO;
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.adPosition) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Delete the row from the data source
            
            self.hasAd = NO;
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
