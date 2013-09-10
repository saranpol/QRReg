//
//  API.h
//  TAT
//
//  Created by saranpol on 7/3/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_VERSION @"1.0"
#define API_HTTP @"http://labs.bkklive.com/vip/"
#define API_HTTPS @"https://labs.bkklive.com/vip/"
//#define API_PREFIX @"/vip/"


typedef void (^APISuccess)(id);
typedef void (^APIFail)(NSError*);

@interface API : NSObject

+ (API *)getAPI;

@property (nonatomic, strong) NSMutableDictionary *mClientInfoDict;
@property (nonatomic, strong) NSMutableDictionary *mDataDict;

// Persistence
- (id)getObject:(NSString*)key;
- (void)saveObject:(id)obj forKey:(NSString*)key;

// API_ONLINE
- (void)api_send:(NSString*)code
         success:(APISuccess)success
         failure:(APIFail)failure;


@end




