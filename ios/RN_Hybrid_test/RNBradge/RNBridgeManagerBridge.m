//
//  RNBridgeManagerBridge.m
//  RN_Hybrid_test
//
//  Created by shibowen on 2020/2/10.
//  Copyright © 2020 shibowen. All rights reserved.
//

#import "RNBridgeManagerBridge.h"
#import <React/RCTBridgeModule.h>

@implementation RNBridgeManagerBridge

@end

@interface RCT_EXTERN_MODULE(RNBradgeManager, NSObject)

RCT_EXTERN_METHOD(backAction)

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

@end
