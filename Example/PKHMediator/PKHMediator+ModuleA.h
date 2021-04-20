//
//  PanMediator+ModuleA.h
//  PanMediator
//
//  Created by Pan on 2020/10/29.
//

#import "PKHMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PKHMediator (ModuleA)

- (UIViewController *)createController:(NSString *)title
                             backColor:(UIColor *)backColor;

- (void)showAlert:(NSString *)title
          content:(NSString *)content
     sureCallback:(dispatch_block_t)sureCallback;

@end

NS_ASSUME_NONNULL_END
