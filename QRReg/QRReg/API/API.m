//
//  API.m
//  TAT
//
//  Created by saranpol on 7/3/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "API.h"
#import "AFNetworking.h"
#import "APIClientHttp.h"
#import "APIClientHttps.h"

@implementation API

@synthesize mClientInfoDict;
@synthesize mDataDict;


static API *instance;

+ (API*)getAPI {
    if (instance == nil) {
        instance = [[API alloc] init];
    }
    return instance;
}

- (API*)init {
    API *a = [super init];
    
    self.mDataDict = [[NSMutableDictionary alloc] init];
    
    self.mClientInfoDict = [[NSMutableDictionary alloc] init];
    [mClientInfoDict setValue:API_VERSION forKey:@"apiv"];
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
	[mClientInfoDict setValue:appVersionString forKey:@"appv"];
	[mClientInfoDict setValue:@"ios" forKey:@"platform"];
    NSString *mid = [UIDevice currentDevice].model;
	[mClientInfoDict setValue:mid forKey:@"mid"];
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    mWidth = screenRect.size.width;
//    mHeight = screenRect.size.height;
//    if(mIsHD)
//        [mClientInfoDict setValue:@"1" forKey:@"hd"];
//    else
//        [mClientInfoDict setValue:@"0" forKey:@"hd"];
//    
//    [mClientInfoDict setObject:[NSString stringWithFormat:@"%d", mWidth] forKey:@"w"];
//    [mClientInfoDict setObject:[NSString stringWithFormat:@"%d", mHeight] forKey:@"h"];
    
    
    return a;
}




// #PERSISTENCE_BEGEIN
#pragma mark - PERSISTENCE

- (id)getObject:(NSString*)key {
    id obj;
    obj = [mDataDict objectForKey:key];
    if(!obj){
        obj = [self loadObject:key];
        if(obj)
            [mDataDict setObject:obj forKey:key];
    }
    return obj;
}

- (id)loadObject:(NSString*)key {
	NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
	NSData *d = [u objectForKey:key];
	if(d){
		id obj = [NSKeyedUnarchiver unarchiveObjectWithData:d];
		return obj;
	}
	return nil;
}

- (void)saveObject:(id)obj forKey:(NSString*)key {
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
	NSData *d = [NSKeyedArchiver archivedDataWithRootObject:obj];
	[u setObject:d forKey:key];
	[u setObject:[NSDate date] forKey:[key stringByAppendingString:@"Date"]];
    [u synchronize];
    [mDataDict setObject:obj forKey:key];
}

- (void)deleteObject:(NSString*)key {
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    [u removeObjectForKey:key];
    [u synchronize];
    [mDataDict removeObjectForKey:key];
}

// #PERSISTENCE_END






// #API_ONLINE_BEGIN
#pragma mark - API_ONLINE

- (NSMutableDictionary*)initialParam {
    return [NSMutableDictionary dictionaryWithDictionary:mClientInfoDict];
}

- (void)api_cancel_all_call {
    [[[APIClientHttps sharedClient] operationQueue] cancelAllOperations];
    [[[APIClientHttp sharedClient] operationQueue] cancelAllOperations];
}

- (void)api_call:(NSString*)api_name
           https:(BOOL)https
          params:(NSMutableDictionary*)params
         success:(APISuccess)success
         failure:(APIFail)failure
{
    NSString *postPath = api_name;//[API_PREFIX stringByAppendingString:api_name];
    
    if(https){
        [[APIClientHttps sharedClient] getPath:postPath
                                     parameters:params
                                        success:^(AFHTTPRequestOperation *operation, id JSON) {
                                            success(JSON);
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                            failure(error);
                                        }];
    }else{
        [[APIClientHttp sharedClient] getPath:postPath
                                    parameters:params
                                       success:^(AFHTTPRequestOperation *operation, id JSON) {
                                           success(JSON);
                                       }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                           failure(error);
                                       }];
    }
}



- (void)api_send:(NSString*)code
         success:(APISuccess)success
         failure:(APIFail)failure
{
    NSMutableDictionary *params = [self initialParam];
    if(code)
        [params setObject:code forKey:@"PERNR"];
    [self api_call:@"vip.php" https:NO params:params success:success failure:failure];
}


// #API_ONLINE_END


    
    





@end
