//
//  MainViewController.h
//  MissingInfo
//
//  Created by Thibaut on 2/17/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskOperator.h"
#import "MainView.h"
#import "LoggerOperator.h"

@interface MainViewController : NSObject
{
    TaskOperator *taskOperator;
    MainView *view;
}


-(void)setupWithUserParams;
-(void)go;
-(void)log:(NSString*)string;


@property(nonatomic, retain) MainView *view;
@property(nonatomic, retain) TaskOperator *taskOperator;

@end
