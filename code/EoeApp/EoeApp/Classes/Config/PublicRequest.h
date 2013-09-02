//
//  PublicRequest.h
//  SKTemplate
//
//  Created by JiaHuang on 12-8-16.
//  Copyright (c) 2012年 尚科. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "PublicObjects.h"
#import "PublicUrl.h"

@interface PublicRequest : NSObject

+ (ASIHTTPRequest *)loadingRequestWithDelegate:(id)delegate;

@end
