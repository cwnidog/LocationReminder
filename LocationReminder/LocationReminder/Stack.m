//
//  Stack.m
//  LocationReminder
//
//  Created by John Leonard on 2/2/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "Stack.h"

@interface Stack()

@property (strong, nonatomic) NSMutableArray *elements;
@property (strong, nonatomic) NSString *firstString;


@end

@implementation Stack

-(instancetype) init
{
  self = [super init];
  
  if (self) // make sure we actually have something
  {
    self.elements = [[NSMutableArray alloc] init];
  }
  
  return self; // send back the stack
} // init()

// push the supplied string onto the stack
-(void) pushString: (NSString *) newString
{
  [_elements addObject:newString];
} // pushString()

// remove the most recently added string from the stack and return its value
- (NSString *) popString
{
  _firstString = _elements[_elements.count - 1];
  [_elements removeLastObject];
  
  return _firstString;
} //popString

- (NSString *) inspect
{
  _firstString = _elements[_elements.count - 1];
  return _firstString;
} // inspect

@end
