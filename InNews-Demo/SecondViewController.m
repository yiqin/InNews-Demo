//
//  SecondViewController.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "SecondViewController.h"

#import "InNewsTextField.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    InNewsTextField *newTextField = [[InNewsTextField alloc] initWithFrame:CGRectMake(10, 60, 300, 450)];
    
    [newTextField addText:@"Most towns find it hard to identify the moment they lost their mojo. Titusville, though, can pinpoint its spiral to a very specific date: February 1, 2003. Seven astronauts were killed that day when the Columbia space shuttle, having completed a 16-day orbital mission, disintegrated upon re–entry over the southern United States. A section of foam roughly the size of a small suitcase had broken off from Columbia’s external tank 82 seconds after its January 16 launch, opening a hole in the left wing and leaving it vulnerable to superheated gasses. NASA control had witnessed this accident as it happened, but after assessing the details it was decided that there had been no significant damage—and, in any case, even if there had been, it was unclear that there was anything they could do to correct it."];
    
    [newTextField addText:@"It wasn’t the first shuttle accident, of course. The Challenger, a tragedy I watched from my first-grade classroom, was probably only read about in history books by kids today. I sat there a little dumbfounded and not fully grasping the situation while my white-haired teacher became overwhelmed with grief. But even the Columbia explosion is ancient to the kinder these days. To a 10-year-old you might as well be talking about the Patty Hearst kidnapping or the sinking of the Bismarck."];
    
    [self.view addSubview:newTextField];
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
