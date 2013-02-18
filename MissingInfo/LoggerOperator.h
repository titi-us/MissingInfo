//
//  LoggerOperator.h
//  MissingInfo
//
//  Created by Thibaut on 2/17/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggerOperator : NSObject
{
    id currentObserver;
}

-(void)log:(NSString*)string;

-(void)setObserver:(id)observer;
+(LoggerOperator*) instance;

@end
