//
//  Stack.h
//  LocationReminder
//
//  Created by John Leonard on 2/2/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

-(instancetype)init;
-(void) pushString: (NSString *) newString;
- (NSString *) popString;
- (NSString *) inspect;
@end
