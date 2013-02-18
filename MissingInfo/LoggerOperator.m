//
//  LoggerOperator.m
//  MissingInfo
//
//  Created by Thibaut on 2/17/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "LoggerOperator.h"

@implementation LoggerOperator


-(void)log:(NSString*)string
{
    if (currentObserver)
    {
        [currentObserver log:string];
    } else
    {
        NSLog(@"%@", string);
    }
}

-(void)setObserver:(id)observer
{
    currentObserver = observer;
}

+(LoggerOperator*) instance;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

@end
