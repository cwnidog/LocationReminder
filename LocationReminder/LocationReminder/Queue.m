//
//  Queue.m
//  LocationReminder
//
//  Created by John Leonard on 2/2/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "Queue.h"

@interface Queue()

@property (strong, nonatomic) NSMutableArray * elements;
@property (strong, nonatomic) NSString *queueString;

@end


@implementation Queue

- (instancetype) init
{
  self = [super init];
  if (self)
  {
    self.elements = [[NSMutableArray alloc] init];
  }
  
  return self;
} // init

// add the supplied string to the queue
- (void) enqueue : (NSString *) queueString
{
  [_elements addObject:queueString];
} // enqueue

// remove the frist string in the queue from the queue and return its value
- (NSString *) dequeue
{
  _queueString = _elements[0];
  [_elements removeObjectAtIndex:0];
  
  return _queueString;
} // dequeue()

// return the value of the first string in the queue
- (NSString *) peek
{
  return _elements[0];
} // peek

@end
