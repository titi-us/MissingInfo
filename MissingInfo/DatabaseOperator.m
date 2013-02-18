//
//  DatabaseOperator.m
//  MissingInfo
//
//  Created by Thibaut on 2/14/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "DatabaseOperator.h"
#import "mysql.h"

@implementation DatabaseOperator

const NSString* SERVER_NAME = @"127.0.0.1";
const NSString* USER_NAME = @"root";
const NSString* PASSWORD = @"";
const NSString* DB_NAME = @"test";

MYSQL mysqlConnection;

-(void) connectWithHost:(NSString*)host User:(NSString*)user Password:(NSString*)password Database:(NSString*)db;
{

    if (mysql_init(&mysqlConnection))
    {
        if (!host)
        {
            host = SERVER_NAME;
        }
        
        if (!user)
        {
            user = USER_NAME;
        }

        if (!password)
        {
            password = PASSWORD;
        }

        if (!db)
        {
            db = DB_NAME;
        }

        
        
        if (!mysql_real_connect(&mysqlConnection,
                                             [host UTF8String],
                                             [user UTF8String],
                                             [password UTF8String],
                                             [db UTF8String],
                                             0, NULL, 0))
        {
             [[LoggerOperator instance] log:[NSString stringWithFormat:@"Failed to connect. Error: %s", mysql_error(&mysqlConnection)]];
            [self close];
        } else
        {
            [[LoggerOperator instance] log:@"Successful"];
            
        }
    } else
    {
        [[LoggerOperator instance] log:@"Not enough memory to create the connection"];
        [self close];
    }
}

-(NSArray*) selectWithCommand:(NSString*)command
{
    if (&mysqlConnection)
    {
                
        // execute query
        
        int res = mysql_query(&mysqlConnection, [command UTF8String]);
        if (res > 0) // error
        {
            [[LoggerOperator instance] log:[NSString stringWithFormat:@"Failed to perform command %@. Error Number: %i", command, res]];
            return nil;
        }
        
        // get result
        
        MYSQL_RES *result = mysql_store_result(&mysqlConnection);
        if (!result)
        {
            [[LoggerOperator instance] log:[NSString stringWithFormat:@"Failed to connect. Error: %s", mysql_error(&mysqlConnection)]];

            return nil;
        }
        
        unsigned int num_fields;
        num_fields = mysql_num_fields(result);
        
        enum enum_field_types convert[num_fields];
        
        MYSQL_FIELD * field;
        unsigned int count = 0;
        while ((field = mysql_fetch_field(result)))
        {
            convert[count] = field->type;
            count++;
        }
        
        
        
        
        NSMutableArray *resultRows = [NSMutableArray array];
        MYSQL_ROW row;
        unsigned int i;
        while ((row = mysql_fetch_row(result)))
        {
            unsigned long *lengths;
            lengths = mysql_fetch_lengths(result);
            NSMutableArray *resRow = [NSMutableArray array];
            for(i = 0; i < num_fields; i++)
            {
                id retVal = nil;
                if (row[i])
                {
                    switch(convert[i]) {
                        case MYSQL_TYPE_BIT:
                            retVal = [NSNumber numberWithUnsignedChar: row[i][0]];
                            break;
                            
                            /* Binary data */
                        case MYSQL_TYPE_TINY_BLOB:
                        case MYSQL_TYPE_MEDIUM_BLOB:
                        case MYSQL_TYPE_BLOB:
                        case MYSQL_TYPE_LONG_BLOB:
//                            if( ( flags & BINARY_FLAG ) > 0 )
//                                retVal = [NSData dataWithBytes: row[i] length: strlen( row[i] )];
//                            else
                                retVal = [NSString stringWithUTF8String: row[i]];
                            break;
                            
                            /* Date and Time */
                        case MYSQL_TYPE_DATE:
                        case MYSQL_TYPE_DATETIME:
                        case MYSQL_TYPE_NEWDATE:
                            retVal = [NSDate dateWithTimeIntervalSince1970: atoll( row[i] )];
                            break;
                        case MYSQL_TYPE_TIMESTAMP:
                            retVal = [NSDate dateWithTimeIntervalSince1970: atoll( row[i] )];
                            break;
                            
                            /* Decimal numeric values */
                        case MYSQL_TYPE_DECIMAL:
                        case MYSQL_TYPE_FLOAT:
                        case MYSQL_TYPE_DOUBLE:
                        case MYSQL_TYPE_NEWDECIMAL:
                            retVal = [NSNumber numberWithFloat: atof( row[i] )];
                            break;
                            
                            /* Numeric values */
                        case MYSQL_TYPE_TINY:
                        case MYSQL_TYPE_SHORT:
                        case MYSQL_TYPE_INT24:
                        case MYSQL_TYPE_YEAR:
                            retVal = [NSNumber numberWithLongLong: atoi( row[i] )];
                            break;
                            
                        case MYSQL_TYPE_LONG:
                        case MYSQL_TYPE_LONGLONG:
                            retVal = [NSNumber numberWithLongLong: atoll( row[i] )];
                            break;
                            
                            /* String & Enum values */
                        case MYSQL_TYPE_STRING:
                        case MYSQL_TYPE_VAR_STRING:
                        case MYSQL_TYPE_VARCHAR:
                        case MYSQL_TYPE_ENUM:
                            retVal = [NSString stringWithUTF8String: row[i]];
                            break;
                            
                            /* NULL and undefined values from here. */
                        case MYSQL_TYPE_NULL:
                        default:
                            retVal = [NSNull null];
                            break;                    
                    }
                }
                else
                {
                    retVal = [NSNull null];
                }
                [resRow addObject:retVal];
            }
            
            [resultRows addObject:resRow];
            
        }

        mysql_free_result(result);
        NSLog(@"result: %@", resultRows);
        
        return resultRows;
    }
    
    return nil;
}


-(void) close
{
    NSLog(@"Closing");
    if (&mysqlConnection)
    {
        mysql_close(&mysqlConnection);
    }
}

@end
