//
//  MainView.m
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "MainView.h"

@implementation MainView
@synthesize drop, form;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    // Drawing code here.
}


-(IBAction)go:(id)sender
{
    NSLog(@"go");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"START" object:self];
}

-(void)appendText:(NSString *)string
{
    NSTextView* textview = [log documentView];
    [textview insertText:[string stringByAppendingString:@"\n"]];
}

@end
