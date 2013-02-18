//
//  AppDelegate.h
//  MissingInfoGUI
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TaskOperator.h"
#import "MainView.h"
#import "MainViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    MainViewController *viewController;
}
@property (assign) IBOutlet NSWindow *window;

@end
