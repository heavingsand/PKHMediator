//
//  PKHMediator.m
//  PKHMediator
//
//  Created by Pan on 2020/10/29.
//

#import "PKHMediator.h"

@implementation PKHMediator

// 单例
+ (instancetype)shareMediator{
    static PKHMediator *retMediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!retMediator) {
            retMediator = [[PKHMediator alloc] init];
        }
    });
    return retMediator;
}

- (id)pan_perform:(NSString *)targetName action:(NSString *)actionName {
    return [self pan_perform:targetName action:actionName args:nil];
}

- (id)pan_perform:(NSString *)targetName action:(NSString *)actionName args:(NSArray *)args {
    
    if (!targetName || !actionName) {
        return nil;
    }
    if ((targetName.length == 0) || (actionName.length == 0)) {
        return nil;
    }
    
    Class targetClass = NSClassFromString(targetName);
    if (!targetClass) {
        return nil;
    }
    
    SEL action = NSSelectorFromString(actionName);
    
    /// 类方法响应
    if ([targetClass respondsToSelector:action]) {
        return [self actionInvocation:action target:targetClass args:args];
    }
    
    NSObject *target = [[targetClass alloc] init];
    if (!target) {
        return nil;
    }
    
    /// 实例方法响应
    if ([target respondsToSelector:action]) {
        return [self actionInvocation:action target:target args:args];
    }
    
    return nil;
}

- (id)actionInvocation:(SEL)action target:(id)target args:(NSArray *)args {
    
    NSMethodSignature* methodSignature = [target methodSignatureForSelector:action];
    
    if (!methodSignature) {
        return nil;
    }
    
    /// 需要处理下基本数据类型(包括传入参数和返回值): 类型翻译表:https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    if (!invocation) {
        return nil;
    }
    
    if ([args isKindOfClass: [NSArray class]]) {
        /**
            这里保证传入参数个数和方法参数个数一致, 防止有些方法有些参数允许传空
            invocation 有2个隐藏参数，所以argument从2开始
         */
        if (args.count == (methodSignature.numberOfArguments - 2)) {
            for (int i = 0; i < args.count; i++) {
                
                const char *argumentType = [methodSignature getArgumentTypeAtIndex:2 + i];
                
                if (strcmp(argumentType, @encode(int)) == 0) {
                    int argument = [args[i] intValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(unsigned int)) == 0) {
                    unsigned int argument = [args[i] unsignedIntValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }

                if (strcmp(argumentType, @encode(NSInteger)) == 0) {
                    NSInteger argument = [args[i] integerValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(NSUInteger)) == 0) {
                    NSUInteger argument = [args[i] unsignedIntegerValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }

                if (strcmp(argumentType, @encode(BOOL)) == 0) {
                    BOOL argument = [args[i] boolValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(float)) == 0) {
                    float argument = [args[i] floatValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(double)) == 0) {
                    double argument = [args[i] doubleValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(long)) == 0) {
                    long argument = [args[i] longValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(unsigned long)) == 0) {
                    unsigned long argument = [args[i] unsignedLongValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(long long)) == 0) {
                    long long argument = [args[i] longLongValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(unsigned long long)) == 0) {
                    unsigned long long argument = [args[i] unsignedLongLongValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(short)) == 0) {
                    short argument = [args[i] shortValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(char)) == 0) {
                    char argument = [args[i] charValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(unsigned char)) == 0) {
                    char argument = [args[i] charValue];
                    [invocation setArgument:&argument atIndex:2 + i];
                    continue;
                }
                
                if (strcmp(argumentType, @encode(void)) == 0) {
                    continue;
                }
                
                id argument = args[i];
                if ([argument isKindOfClass:[NSNull class]]) {
                    continue;
                }
                [invocation setArgument:&argument atIndex:2 + i];
            }
        }
    }
    
    [invocation setTarget:target];
    [invocation setSelector:action];
    [invocation invoke];
    
    const char* returnType = [methodSignature methodReturnType];
    
    if (strcmp(returnType, @encode(void)) == 0) {
        return nil;
    }
    
    if (strcmp(returnType, @encode(int)) == 0) {
        int result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(unsigned int)) == 0) {
        unsigned int result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(returnType, @encode(NSInteger)) == 0) {
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(NSUInteger)) == 0) {
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(returnType, @encode(BOOL)) == 0) {
        BOOL result = NO;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(float)) == 0) {
        float result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(double)) == 0) {
        double result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(long)) == 0) {
        long result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(unsigned long)) == 0) {
        unsigned long result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(long long)) == 0) {
        long long result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(unsigned long long)) == 0) {
        unsigned long long result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(short)) == 0) {
        short result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(char)) == 0) {
        char result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(unsigned char)) == 0) {
        unsigned char result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(returnType, @encode(dispatch_block_t)) == 0) {
        __weak id returnValue;
        [invocation getReturnValue:&returnType];
        return returnValue;
    }

    /// 需要延长对象类型的生命周期, 防止提前释放导致野指针
    __autoreleasing id returnValue;
    [invocation getReturnValue:&returnValue];
    return returnValue;
    
}

@end
