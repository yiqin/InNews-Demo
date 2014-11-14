//
//  SecondViewController.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "SecondViewController.h"

#import "CocoaNewsTextView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CocoaNewsTextView *newTextView = [[CocoaNewsTextView alloc] initWithFrame:CGRectMake(10, 60, 300, 450)];
    [newTextView setFont: [UIFont systemFontOfSize:16]];
    
    // [newTextField addImage:[[NSURL alloc] initWithString:@"http://files.parsetfss.com/9e18e2cd-80ea-4c8f-a549-38dddd225778/tfss-f3bd7db0-eb72-4af5-847e-6a55d4e5ec69-1-2YZhInuwWHCrDcUbK92nzA.jpeg"]];
    
    newTextView.text = @"Most towns find it hard to identify the moment they lost their mojo. Titusville, though, can pinpoint its spiral to a very specific date: February 1, 2003. Seven astronauts were killed that day when the Columbia space shuttle, having completed a 16-day orbital mission, disintegrated upon re–entry over the southern United States. A section of foam roughly the size of a small suitcase had broken off from Columbia’s external tank 82 seconds after its January 16 launch, opening a hole in the left wing and leaving it vulnerable to superheated gasses. NASA control had witnessed this accident as it happened, but after assessing the details it was decided that there had been no significant damage—and, in any case, even if there had been, it was unclear that there was anything they could do to correct it. \n\nIt wasn’t the first shuttle accident, of course. The Challenger, a tragedy I watched from my first-grade classroom, was probably only read about in history books by kids today. I sat there a little dumbfounded and not fully grasping the situation while my white-haired teacher became overwhelmed with grief. But even the Columbia explosion is ancient to the kinder these days. To a 10-year-old you might as well be talking about the Patty Hearst kidnapping or the sinking of the Bismarck.\n\nIt’s hard to know what any of us will remember about October 31, 2014, the day Virgin Galactic’s SpaceShipTwo fell to pieces nine miles above the Earth, killing co-pilot Michael Alsbury and leaving his co-worker Peter Siebold on a terrifying plummet towards the Mojave Desert. Perhaps we won’t recall it very much at all: Who knows where they were when a fuel tank for the same craft exploded in 2007 and killed three technicians? Private space travel hasn’t entranced the world in the same way as NASA’s pioneering missions. Titusville will remember, though. Just 20 miles northwest of Kennedy Space Center in Florida, it used to have a proud nickname: Space City USA. It couldn’t help but be bolted to the dizzying boom of the 1950s and ‘60s, and the local space industry helped create myriad jobs by giving work to nearby aerospace companies. \n\nThere were so many jobs, in fact, that the local population ballooned from around 6,000 in 1960 to just over 30,000 in a decade.";
    
    [newTextView addImage:[[NSURL alloc] initWithString:@"http://files.parsetfss.com/9e18e2cd-80ea-4c8f-a549-38dddd225778/tfss-1a374683-4a4f-4fba-b0a8-4abf5a4f6aec-10714050_10152405010815988_2510931489345423974_o.png"]];
    
    [newTextView addText: @"Titusville will remember, though. Just 20 miles northwest of Kennedy Space Center in Florida, it used to have a proud nickname: Space City USA. It couldn’t help but be bolted to the dizzying boom of the 1950s and ‘60s, and the local space industry helped create myriad jobs by giving work to nearby aerospace companies. There were so many jobs, in fact, that the local population ballooned from around 6,000 in 1960 to just over 30,000 in a decade." style:UIArticleStyleOne];
    
    
    
    [self.view addSubview:newTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
