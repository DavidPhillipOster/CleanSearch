//  RecentMenuRootView.h
//
//  Created by david on 5/25/25.
// License: Apache Version 2.

#import <Cocoa/Cocoa.h>

@class BaseView;

// overlay the system magnifying glass icon, and catch clicks to show the recent searches menu.
// Handle the menu commands, and the enable state.
@interface RecentMenuRootView : NSView
@property (weak) BaseView *baseView;

- (void)rebuildRecentSearchesMenu;
@end
