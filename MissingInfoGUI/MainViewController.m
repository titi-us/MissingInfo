//
//  MainViewController.m
//  MissingInfo
//
//  Created by Thibaut on 2/17/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize taskOperator, view;

-(id)init
{
    self = [super init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(go) name:@"START" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(log) name:@"LOG" object:nil];
    
    [[LoggerOperator instance] setObserver:self];
    
    return self;
}

-(void)log:(NSString*)string
{
    if (view != nil)
    {
        [view appendText:string];
    }
   // warn current view to display log.
}

-(void)go
{
    NSLog(@"go");
    if (taskOperator)
    {
        MysqlInfoView* form = [view form];
        DropView* dropView = [view drop];
        
        [taskOperator setHost:[[form server] stringValue]];
        [taskOperator setUsername:[[form username] stringValue]];
        [taskOperator setPassword:[[form password] stringValue]];
        [taskOperator setDatabase:[[form database] stringValue]];
        [taskOperator setFilePath:[dropView filePath]];
        [taskOperator run];
        
        NSUserDefaults *userParams = [NSUserDefaults standardUserDefaults];
        [userParams setObject:[[form server] stringValue] forKey:@"app-server"];
        [userParams setObject:[[form username] stringValue] forKey:@"app-username"];
        [userParams setObject:[[form password] stringValue] forKey:@"app-password"];
        [userParams setObject:[[form database] stringValue] forKey:@"app-database"];
    }
}


-(void)setupWithUserParams
{
    NSUserDefaults *userParams = [NSUserDefaults standardUserDefaults];
    
    MysqlInfoView* form = [view form];
    
    [[form server] setStringValue:[userParams stringForKey:@"app-server"] ? [userParams stringForKey:@"app-server"] : @""];
    [[form username] setStringValue:[userParams stringForKey:@"app-username"] ? [userParams stringForKey:@"app-username"] : @""];
    [[form password] setStringValue:[userParams stringForKey:@"app-password"] ? [userParams stringForKey:@"app-password"] : @""];
    [[form database] setStringValue:[userParams stringForKey:@"app-database"] ? [userParams stringForKey:@"app-database"] : @""];
    
}


@end
