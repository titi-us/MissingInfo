//
//  FileParser.m
//  MissingInfo
//
//  Created by Thibaut on 2/14/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "FileOperator.h"

@implementation FileOperator
@synthesize inputElements, outputElements;


-(void)parseInput:(NSString*) path
{
    NSLog(@"fileRoot: %@", path);
    
    // read everything from text
    NSString* fileContents =
    [NSString stringWithContentsOfFile:path
                              encoding:NSMacOSRomanStringEncoding error:nil];
   
    
    // first, separate by new line
    inputElements =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    
    
}

-(NSUInteger)getInputLength
{
    return self.inputElements ? self.inputElements.count : 0;
}


-(NSArray*)getElementsAtPosition:(NSUInteger) position
{
    
    if (self.inputElements.count > position )
    {
        NSString* line = self.inputElements[position];
        NSMutableArray* retVal = [NSMutableArray arrayWithArray:[line componentsSeparatedByString:@"," ]];
        return retVal;
    } else
    {
        NSLog(@"Error, cannot find item at position %li", (unsigned long)position);
    }
    return nil;
}


-(void)writeOutput:(NSArray *)output ToPath:(NSString*)path
{
    
    NSString* fileOutput = @"";//[NSString string][output s]
    for (int i=0; i<output.count; i++)
    {
        fileOutput = [fileOutput stringByAppendingString:[NSString stringWithFormat:@"%@\n",[(ScriptRow*) output[i] toString]]];
    }
    
    [fileOutput writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:NULL];
    
}

@end
