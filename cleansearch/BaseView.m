//  BaseView.m
//
//  Created by david on 1/29/25.
// License: Apache Version 2.

#import "BaseView.h"

#import "RecentMenuRootView.h"

@interface BaseView ()
@property RecentMenuRootView *recentMenuRootView;
@end

@implementation BaseView

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
  [[NSColor.systemGreenColor colorWithAlphaComponent:0.15] set];
  NSRectFill(self.bounds);
}

- (void)setSearchField:(NSTextField *)searchField {
  _searchField = searchField;
  if (searchField) {
    self.recentMenuRootView = [self constructMenuRoot];
    self.recentMenuRootView.baseView = self;
    [searchField addSubview:self.recentMenuRootView];
    [self.recentMenuRootView rebuildRecentSearchesMenu];
  }
}

- (RecentMenuRootView *)constructMenuRoot {
  CGRect frame = self.searchField.bounds;
  frame.size.width = frame.size.height + 9;
  return [[RecentMenuRootView alloc] initWithFrame:frame];
}

@end
