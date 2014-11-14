//
//  InNews.h
//  InNews-Demo
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CocoaNewsTextView.h"

@interface CocoaNews : NSObject

/*!
 Initialize Innews. Note: actually only apiKey is used to find YQApp on Parse.com. applicationId is needed later.
 @param applicationId The user session token.
 @param apiKey The user app objectId.
 */
+ (void)setApplicationId:(NSString*)applicationId apiKey:(NSString*)apiKey;

+ (NSString*)getApplicationId;
+ (NSString*)getApiKey;

@end
