//
//  main.c
//  MissingInfo
//
//  Created by Thibaut on 2/14/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskOperator.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Hello, World!");
        TaskOperator *taskOp = [[TaskOperator alloc] init];
        [taskOp run];
    }
    return 0;
}

