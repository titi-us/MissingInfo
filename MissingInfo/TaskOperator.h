//
//  TaskOperator.h
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileOperator.h"
#import "DatabaseOperator.h"
#import "ScriptRow.h"

@interface TaskOperator : NSObject
{
    NSString *filePath;
    NSString *host;
    NSString *username;
    NSString *password;
    NSString *database;
}

-(void)run;

@property(nonatomic, retain) NSString *filePath;
@property(nonatomic, retain) NSString *host;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) NSString *database;

@end
