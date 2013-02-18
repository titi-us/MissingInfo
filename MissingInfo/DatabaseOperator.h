//
//  DatabaseOperator.h
//  MissingInfo
//
//  Created by Thibaut on 2/14/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoggerOperator.h"

@interface DatabaseOperator : NSObject
{
    //MysqlConnection *connection;
}


-(void) connectWithHost:(NSString*)host User:(NSString*)user Password:(NSString*)password Database:(NSString*)db;
-(NSArray*) selectWithCommand:(NSString*)command;

@end
