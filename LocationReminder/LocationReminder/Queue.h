//
//  Queue.h
//  LocationReminder
//
//  Created by John Leonard on 2/2/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

- (instancetype) init;
- (void) enqueue : (NSString *) queueString;
- (NSString *) dequeue;
- (NSString *) peek;


@end
