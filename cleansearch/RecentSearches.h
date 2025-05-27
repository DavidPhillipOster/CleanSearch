//
//  RecentSearches.h
//  CleanSearch
//
//  Created by david on 5/25/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RecentSearchesDelegate;

/// persistent array of recent searches in chronological order.
@interface RecentSearches : NSObject
@property(weak) id<RecentSearchesDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)addSearch:(NSString *)s;

- (void)clearSearches;

- (NSArray<NSString *> *)searches;

@end

@protocol RecentSearchesDelegate <NSObject>

- (void)recentSeachesChanged:(RecentSearches *)searches;

@end


NS_ASSUME_NONNULL_END
