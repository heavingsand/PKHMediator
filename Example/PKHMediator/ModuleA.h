//
//  ModuleA.h
//  ZYMediator
//
//  Created by Pan on 2020/9/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModuleA : NSObject

- (UIViewController *)target_createController:(NSString *)title
                                    backColor:(UIColor *)backColor;

+ (void)target_showAlert:(NSString *)title
                 content:(NSString *)content
            sureCallback:(dispatch_block_t)sureCallback;

@end

NS_ASSUME_NONNULL_END
