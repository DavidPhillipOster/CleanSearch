//
//  RecentSearches.m
//  CleanSearch
//
//  Created by david on 5/25/25.
//

#import "RecentSearches.h"

static NSString *const searchesKey = @"searches";

static RecentSearches *sSearches;


@interface RecentSearches ()
@property NSArray<NSString *> *a;
@end

@implementation RecentSearches

+ (instancetype)sharedInstance {
  if (nil == sSearches) {
    sSearches = [[self alloc] init];
    NSArray<NSString *> *a = [NSUserDefaults.standardUserDefaults valueForKey:searchesKey];
    if (nil == a || ![a isKindOfClass:[NSArray class]]) {
      a = @[];
    }
    sSearches.a = a;
  }
  return sSearches;
}

- (void)addSearch:(NSString *)s {
  NSMutableArray *ma = [self.a mutableCopy];
  NSUInteger index = [ma indexOfObject:s];
  if (NSNotFound != index) {
    [ma removeObjectAtIndex:index];
  }
  [ma insertObject:s atIndex:0];
  while (10 < ma.count) {
    [ma removeLastObject];
  }
  if (![ma isEqual:self.a]) {
    self.a = ma;
    [NSUserDefaults.standardUserDefaults setValue:self.a forKey:searchesKey];
    [self.delegate recentSeachesChanged:self];
  }
}

- (void)clearSearches {
  self.a = @[];
  [NSUserDefaults.standardUserDefaults setValue:self.a forKey:searchesKey];
  [self.delegate recentSeachesChanged:self];
}

- (NSArray<NSString *> *)searches {
  return self.a;
}

@end
