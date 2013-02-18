//
//  DropView.h
//  Test
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DropView : NSBox
{
    NSString *filePath;
}

@property(nonatomic, retain) NSString *filePath;

@end
