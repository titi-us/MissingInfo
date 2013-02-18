//
//  MainView.h
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DropView.h"
#import "MysqlInfoView.h"

@interface MainView : NSView
{
    IBOutlet MysqlInfoView  *form;
    IBOutlet DropView *drop;
    IBOutlet NSScrollView *log;
    IBOutlet NSButton *goButton;
}

@property (nonatomic,retain) IBOutlet MysqlInfoView  *form;
@property (nonatomic,retain) IBOutlet DropView *drop;

-(IBAction)go:(id)sender;
-(void)appendText:(NSString*)string;

@end
