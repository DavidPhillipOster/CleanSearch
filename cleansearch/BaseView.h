//  BaseView.h
//
//  Created by david on 1/29/25.
// License: Apache Version 2.


#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

// Serves as the controller for this app.
@interface BaseView : NSView
@property (nonatomic) IBOutlet NSTextField *searchField;
@end

NS_ASSUME_NONNULL_END
