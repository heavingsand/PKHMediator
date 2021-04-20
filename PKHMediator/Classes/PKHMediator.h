//
//  PKHMediator.h
//  PKHMediator
//
//  Created by Pan on 2020/10/29.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Safety.h"

NS_ASSUME_NONNULL_BEGIN

@interface PKHMediator : NSObject

// 单例
+ (instancetype)shareMediator;

/// 方法调用
/// @param targetName 方法名
/// @param actionName 参数名
- (id)pan_perform:(nonnull NSString *)targetName
           action:(nonnull NSString *)actionName;
- (id)pan_perform:(nonnull NSString *)targetName
           action:(nonnull NSString *)actionName
             args:(nullable NSArray *)args;

/// 方法直接调用(适用于所有方法的调起)
/// @param action 方法
/// @param target 响应对象
/// @param args 函数参数
- (id)actionInvocation:(SEL)action
                target:(id)target
                  args:(nullable NSArray *)args;

@end

NS_ASSUME_NONNULL_END
