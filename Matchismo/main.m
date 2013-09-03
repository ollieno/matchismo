//
//  main.m
//  Matchismo
//
//  Created by Jeroen Olthof on 28-08-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardGameAppDelegate.h"

typedef int (*PYStdWriter)(void *, const char *, int);
static PYStdWriter _oldStdWrite;

int __pyStderrWrite(void *inFD, const char *buffer, int size)
{
    if ( strncmp(buffer, "AssertMacros:", 13) == 0 ) {
        return 0;
    }
    return _oldStdWrite(inFD, buffer, size);
}

int main(int argc, char *argv[])
{
    _oldStdWrite = stderr->_write;
    stderr->_write = __pyStderrWrite;
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([CardGameAppDelegate class]));
    }
}