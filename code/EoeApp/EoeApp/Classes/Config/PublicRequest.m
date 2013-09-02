//
//  PublicRequest.m
//  SKTemplate
//
//  Created by JiaHuang on 12-8-16.
//  Copyright (c) 2012年 尚科. All rights reserved.
//

#import "PublicRequest.h"
#import "JSONKit.h"
#import "ASIFormDataRequest.h"

@interface PublicRequest ()

+ (ASIHTTPRequest *)postDataWithUrl:(NSString *)pUrl
                           delegate:(id)pDelegate
                             params:(NSMutableDictionary *)pParams ;

+ (ASIHTTPRequest *)getDataWithUrl:(NSString *)pUrl
                           delegate:(id)pDelegate
                             params:(NSMutableDictionary *)pParams ;

+ (ASIHTTPRequest *)loadDataWithDelegate:(id)pDelegate
                                  params:(NSMutableDictionary *)pParams
                                  method:(NSString *)pMethod;

+ (NSString *)getMethodUrlwithDict:(NSMutableDictionary *)dict
                       withMainUrl:(NSString *)pMainUrl;

@end

@implementation PublicRequest


+ (ASIHTTPRequest *)loadingRequestWithDelegate:(id)delegate {
	NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithCapacity:5];

	[tempDictionary setObject:@"dfdfd" forKey:@"uuid"];

	return [PublicRequest loadDataWithDelegate:delegate params:tempDictionary method:@"GET"];
}

#pragma mark -
#pragma mark Private mehtod

+ (NSString *)getMethodUrlwithDict:(NSMutableDictionary *)dict
                            withMainUrl:(NSString *)pMainUrl {
    
	NSMutableString *requestUrlStr = [NSMutableString stringWithString:pMainUrl];
	NSArray *keys = dict.allKeys;
	for ( int i = 0;i<keys.count;i++ ) {
        NSString *key = [keys objectAtIndex:i];
        if (i == 0) {
            [requestUrlStr appendString:[NSString stringWithFormat:@"?%@=%@", key, [dict objectForKey:key]]];
        } else {
            [requestUrlStr appendString:[NSString stringWithFormat:@"&%@=%@", key, [dict objectForKey:key]]];
        }
		
	}
	return requestUrlStr;
}

// 通过post的方式发送数据
+ (ASIHTTPRequest *)postDataWithUrl:(NSString *)pUrl
                           delegate:(id)pDelegate
                             params:(NSMutableDictionary *)pParams{
	NSURL *theUrl = [NSURL URLWithString:pUrl];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:theUrl];

	[request setDelegate:pDelegate];
	for ( NSString *key in pParams.allKeys ) {
		[request setPostValue:[pParams objectForKey:key] forKey:key];
	}
	[request setRequestMethod:@"POST"];
	[request startAsynchronous];
	return request;
}

// 通过get的方式发送数据
+ (ASIHTTPRequest *)getDataWithUrl:(NSString *)pUrl
                          delegate:(id)pDelegate
                            params:(NSMutableDictionary *)pParams {
	NSURL *theUrl = [NSURL URLWithString:pUrl];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:theUrl];
	[request setDelegate:pDelegate];
	[request setRequestMethod:@"GET"];
	[request startAsynchronous];
	return request;
}

// 包装后发送数据
+ (ASIHTTPRequest *)loadDataWithDelegate:(id)pDelegate
                                  params:(NSMutableDictionary *)pParams
                                  method:(NSString *)pMethod {
    
	if ( [pMethod isEqualToString:@"GET"] ) {
        NSString *url = [PublicRequest getMethodUrlwithDict:pParams withMainUrl:kMainRequestUrl];
		return  [PublicRequest getDataWithUrl:url delegate:pDelegate params:pParams];
	} else {
		return [PublicRequest postDataWithUrl:kMainRequestUrl delegate:pDelegate params:pParams];
	}
}

@end