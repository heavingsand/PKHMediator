//
//  NSMutableArray+Safety.m
//  ZYMediator
//
//  Created by Pan on 2020/9/30.
//

#import "NSMutableArray+Safety.h"

@implementation NSMutableArray (Safety)

- (void)safaAddObject:(id)object {
    if (!object) {
        [self addObject:[NSNull null]];
        return;
    }
    [self addObject:object];
}

@end
