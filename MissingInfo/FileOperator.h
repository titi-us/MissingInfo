//
//  FileParser.h
//  MissingInfo
//
//  Created by Thibaut on 2/14/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScriptRow.h"

@interface FileOperator : NSObject
{
    NSArray* inputElements; // array of array
    NSArray* outputElements; // array of array
}

// input
-(void)parseInput:(NSString*) path;
-(NSUInteger)getInputLength;
-(NSMutableArray*)getElementsAtPosition:(NSUInteger) position;

// output
-(void)writeOutput:(NSArray *)output ToPath:(NSString*)path;

@property (nonatomic, retain) NSArray* inputElements;
@property (nonatomic, retain) NSArray* outputElements;


@end
