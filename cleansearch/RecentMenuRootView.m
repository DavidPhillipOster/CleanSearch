//  RecentMenuRootView.m
//
//  Created by david on 5/25/25.
// License: Apache Version 2.

#import "RecentMenuRootView.h"

#import "BaseView.h"
#import "RecentSearches.h"

@interface RecentMenuRootView () <NSMenuItemValidation, RecentSearchesDelegate>

@end

@implementation RecentMenuRootView

- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if (self) {
    RecentSearches.sharedInstance.delegate = self;
  }
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  CGRect r = self.bounds;
  r.origin.x = 18;
  r.origin.y = 16;
  r.size.width = 6;
  r.size.height = 6;
  NSImage *down = [NSImage imageNamed:@"OCRDown"];
  [down drawInRect:r];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
  if (menuItem.action == @selector(recentSearch:)) {
    return YES;
  } else if (menuItem.action == @selector(clearMenu:)) {
    return 0 < RecentSearches.sharedInstance.searches.count;
  }
  return NO;
}

- (void)recentSearch:(NSMenuItem *)sender {
  self.baseView.searchField.stringValue = sender.title;
}

- (void)clearMenu:(NSMenuItem *)sender {
  [RecentSearches.sharedInstance clearSearches];
}

- (void)mouseDown:(NSEvent *)theEvent {
  [NSMenu popUpContextMenu:self.menu withEvent:theEvent forView:self];
}

- (void)resetCursorRects {
  [self addCursorRect: [self bounds] cursor:[NSCursor arrowCursor]];
}

- (void)rebuildRecentSearchesMenu {
  NSMenu *recentsMenu = [[NSMenu alloc] initWithTitle:@""];
  for (NSString *s in RecentSearches.sharedInstance.searches) {
    [recentsMenu addItem:[[NSMenuItem alloc] initWithTitle:s action:@selector(recentSearch:) keyEquivalent:@""]];
  }
  [recentsMenu addItem:[NSMenuItem separatorItem]];
  [recentsMenu addItem:[[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Clear Menu", @"") action:@selector(clearMenu:) keyEquivalent:@""]];
  recentsMenu.font = [NSFont systemFontOfSize:[NSFont smallSystemFontSize]];
  self.menu = recentsMenu;
}

- (void)recentSeachesChanged:(RecentSearches *)searches {
  [self rebuildRecentSearchesMenu];
}

@end

