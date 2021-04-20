//
//  NSMutableArray+Safety.h
//  ZYMediator
//
//  Created by Pan on 2020/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Safety)

- (void)safaAddObject:(id)object;

@end

NS_ASSUME_NONNULL_END
