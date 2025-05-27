//  main.m
//
//  Created by david on 1/29/25.
// License: Apache Version 2.

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

static void Usage(void) {
  fprintf(stderr, "usage: cleansearch param1 [params…] -- do a clean search in the default browser\n"
  "\t-n param1 [params…] --  write URLs to stdout, without actually doing the search.\n");
}

static NSString *ArgsAsString(int i, int argc, const char * argv[]){
  NSMutableString *s = [NSMutableString string];
  for (;i < argc; ++i) {
    [s appendString: [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding]];
    if (i + 1 < argc) {
      [s appendString:@" "];
    }
  }
  return s;
}

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    int skip = 1;
    // Setup code that might create autoreleased objects goes here.
    if (skip < argc) {
      if (0 == strcmp(argv[skip], "-NSDocumentRevisionsDebugMode")){
        skip += 2;
      }
    }
    if (skip < argc) {
      if (argv[1][0] == '-') {
        if (argv[1][1] == 'n') {
          NSString *s = ArgsAsString(skip+1, argc, argv);
          printf("%s\n", [SanitizedSearchURLString(s) UTF8String]);
          return 0;
        } else {
          Usage();
          return -1;
        }
      }
      NSString *s = ArgsAsString(1, argc, argv);
      BOOL wasOK = [[NSWorkspace sharedWorkspace] openURL:URL(SanitizedSearchURLString(s))];
      return wasOK ? 0 : -1;
    }
  }
  return NSApplicationMain(argc, argv);
}
