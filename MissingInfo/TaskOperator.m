//
//  TaskOperator.m
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "TaskOperator.h"

@implementation TaskOperator
@synthesize host, username, database, password, filePath;


- (void) run
{
    FileOperator* fileOperator = [[FileOperator alloc] init];
    
    if (![self filePath])
    {
        NSLog(@"no file path specified");
        return;
    }
    [fileOperator parseInput:[self filePath]];//@"/Users/thibaut/Desktop/campaigns.csv"
    
    NSUInteger len = [fileOperator getInputLength];
    
    
    DatabaseOperator *mysql = [[DatabaseOperator alloc] init];
    [mysql connectWithHost:[self host] User:[self username] Password:[self password] Database:[self database]];

    NSMutableArray *resultArray = [NSMutableArray array];
    for (uint i=0; i < len; i++)
    {
        ScriptRow *row = [[ScriptRow alloc]initWithColumn:[fileOperator getElementsAtPosition:i]];
        [row updateWithEpfSong:[mysql selectWithCommand:[row getEpfSongQuery]]];
        [row updateWithEpfSongMatch:[mysql selectWithCommand:[row getEpfSongMatchQuery]]];
        [row updateWithEpfCollectionMatch:[mysql selectWithCommand:[row getEpfCollectionMatchQuery]]];
        [row updateWithEpfCollection:[mysql selectWithCommand:[row getEpfCollectionQuery]]];
        [resultArray addObject:row];
    }
    
    
    [fileOperator writeOutput:resultArray ToPath:@"/Users/thibaut/Desktop/campaigns-test.csv"];
    
}
@end
