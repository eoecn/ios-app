//
//  PublicParseResponse.m
//  SKTemplate
//
//  Created by JiaHuang on 12-9-10.
//  Copyright (c) 2012年 suncco. All rights reserved.
//

#import "PublicParseResponse.h"

@implementation PublicParseResponse


+ (BOOL)parseLoadingData:(NSString *)resultData getMsg:(NSString **)msg {
	NSError *error = nil;
	NSDictionary *items = [resultData objectFromJSONStringWithParseOptions:JKParseOptionNone error:&error];

	if ( error != nil ) {
		// NSLog(@"数据解析错误:%@",error);
		*msg = @"数据错误";
		return NO;
	}
	*msg = [items objectForKey:@"msg"];
	if ( [[items objectForKey:@"error_code"]intValue] == 0 ) {
		NSDictionary *data = [items objectForKey:@"data"];
		int device_statu = [[data objectForKey:@"device_statu"]intValue];
		switch ( device_statu ) {
			case 0:
				return YES;

			case 1:
				// NSLog(@"设备被冻结");
				return NO;

			case 2:
				// NSLog(@"设备丢失");
				return NO;

			default:
				return NO;
		}
	} else {
		return NO;
	}
}

@end


