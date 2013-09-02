//
//  PublicParseResponse.h
//  SKTemplate
//
//  Created by JiaHuang on 12-9-10.
//  Copyright (c) 2012年 Suncco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "PublicObjects.h"

@interface PublicParseResponse : NSObject

+ (BOOL)parseLoadingData:(NSString *)resultData getMsg:(NSString **)msg;

@end
