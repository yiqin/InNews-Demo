//
//  InNews.m
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "CocoaNews.h"
#import "YQParse.h"

@interface CocoaNews ()

@property(nonatomic, strong) NSString *applicationId;
@property(nonatomic, strong) NSString *apiKey;

@end


@implementation CocoaNews

+ (instancetype)sharedManager
{
    static CocoaNews *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _applicationId = @"";
        _apiKey = @"";
    }
    return self;
}

+ (void)setApplicationId:(NSString*)applicationId apiKey:(NSString*)apiKey
{
    // Parse Authorization
    [YQParse setApplicationId:@"WpVs4S6jbgi7KoLIDi6YAnuBr6MMBn6HfeiD30Vn"
                   restApiKey:@"WSwpkuQWjwJwaDYb0zKUj9CzRuKZP9rgkxsPj2pY"];
    
    NSLog(@"*************************************");
    NSLog(@"**********     0.1.0     ************");
    NSLog(@"****** Update date: 11/13/2015 ******");
    NSLog(@"*************************************");
    
    CocoaNews *shared = [CocoaNews sharedManager];
    shared.applicationId = applicationId;
    shared.apiKey = apiKey;
}

+ (NSString*)getApplicationId
{
    CocoaNews *shared = [CocoaNews sharedManager];
    return shared.applicationId;
}

+ (NSString*)getApiKey
{
    CocoaNews *shared = [CocoaNews sharedManager];
    return shared.apiKey;
}





@end
