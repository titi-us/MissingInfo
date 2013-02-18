//
//  DropView.m
//  Test
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "DropView.h"

@implementation DropView

@synthesize filePath;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self registerForDraggedTypes:
     [NSArray arrayWithObject: NSFilenamesPboardType]];
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}


#pragma dragging

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >)sender
{
    
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];

    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        if (sourceDragMask & NSDragOperationLink) {
            return NSDragOperationLink;
        } else if (sourceDragMask & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }

    return NSDragOperationNone;
}


- (void)draggingExited:(id < NSDraggingInfo >)sender
{
    
}

- (BOOL)prepareForDragOperation:(id < NSDraggingInfo >)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        
        // Depending on the dragging source and modifier keys,
        // the file data may be copied or linked
        if (sourceDragMask & NSDragOperationLink) {
            NSLog(@"copied %@", files);
            if (files && files.count > 0)
            {
                filePath = files[0];
            } else
            {
                filePath = NULL;
            }
            
        } else {
             NSLog(@"linked");
        }
    }

    return YES;
}

@end
