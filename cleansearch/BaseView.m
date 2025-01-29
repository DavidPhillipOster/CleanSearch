//  BaseView.m
//
//  Created by david on 1/29/25.
// License: Apache Version 2.

#import "BaseView.h"

@implementation BaseView

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
  [[NSColor.systemGreenColor colorWithAlphaComponent:0.15] set];
  NSRectFill(self.bounds);
}

@end
