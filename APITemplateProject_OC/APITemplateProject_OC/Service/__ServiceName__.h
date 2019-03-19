//
//  __ServiceName__.h
//  APITemplateProject_OC
//
//  Created by casa on 2019/3/18.
//  Copyright © 2019 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CTNetworking/CTNetworking.h>

extern NSString * const kServiceIdentifier__ServiceName__;

NS_ASSUME_NONNULL_BEGIN

@interface __ServiceName__ : NSObject <CTServiceProtocol>

@property (nonatomic, assign) CTServiceAPIEnvironment apiEnvironment;

@end

NS_ASSUME_NONNULL_END
