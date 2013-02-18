//
//  AppDelegate.m
//  MissingInfoGUI
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    MainView *mainView = (MainView*)[_window contentView];
    
    viewController = [[MainViewController alloc] init];
    
    TaskOperator * taskOperator = [[TaskOperator alloc] init];
    [viewController setView:mainView];
    [viewController setTaskOperator:taskOperator];
    [viewController setupWithUserParams];
    
    NSLog(@"Init");
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}
@end
