//  AppDelegate.m
//
//  Created by david on 1/29/25.
// License: Apache Version 2.

#import <Cocoa/Cocoa.h>

/// The set of characters that can be in a query parameter without messing up the parsing of the entire URL.
NSCharacterSet *Allowed(void){
  static NSMutableCharacterSet *charSet = nil;
  if (nil == charSet) {
    charSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [charSet removeCharactersInString:@"=&+"];
  }
  return charSet;
}

/// given a string from the user, make it safe to put into a URL query parameter.
NSString *Sanitize(NSString *s){
  s = [s stringByAddingPercentEncodingWithAllowedCharacters:Allowed()];
  return s;
}

/// given a sanitized string, return the entire URL string to pass through the browser to see a search resule
NSString *SearchURLString(NSString *s){
  // based on an example from Safari https://www.google.com/search?client=safari&rls=en&q=clean&ie=UTF-8&oe=UTF-8
  return [NSString stringWithFormat:@"https://www.google.com/search?client=safari&rls=en&q=%@&ie=UTF-8&oe=UTF-8&udm=14", s];
}

/// given an entire URL string, make an NSURL
NSURL *URL(NSString *s) {
  return [NSURL URLWithString:s];
}

/// Given a string from the user, search for it in the default browser.
void DoSearch(NSString *s){
  BOOL wasOK = [[NSWorkspace sharedWorkspace] openURL:URL(SearchURLString(Sanitize(s)))];
  if (!wasOK) {
    NSString *reason = [NSString stringWithFormat:@"Could not search for ‘%@’", s];
    [NSApp presentError:[NSError errorWithDomain:@"app" code:1 userInfo:@{
      NSLocalizedDescriptionKey: reason
    }]];
  }
}

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property IBOutlet NSWindow *window;
@property IBOutlet NSTextField *searchField;
@end

@implementation AppDelegate

/// Action for the search menu item, search button, or hitting return in the search field
- (IBAction)doSearch:(id)sender {
  NSString *s = self.searchField.stringValue;
  if ([s length]) {
    DoSearch(s);
  }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
  return YES;
}


@end
