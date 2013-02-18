//
//  MysqlInfoView.h
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MysqlInfoView : NSView
{
    IBOutlet NSTextField* server;
    IBOutlet NSTextField* username;
    IBOutlet NSSecureTextField* password;
    IBOutlet NSTextField* database;
}

@property (nonatomic,retain) IBOutlet NSTextField* server;
@property (nonatomic,retain) IBOutlet NSTextField* username;
@property (nonatomic,retain) IBOutlet NSSecureTextField* password;
@property (nonatomic,retain) IBOutlet NSTextField* database;

@end
