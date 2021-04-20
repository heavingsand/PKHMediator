//
//  ModuleA.m
//  ZYMediator
//
//  Created by Pan on 2020/9/30.
//

#import "ModuleA.h"

@implementation ModuleA

- (UIViewController *)target_createController:(NSString *)title backColor:(UIColor *)backColor {
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = backColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    label.text = title;
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [controller.view addSubview:label];
    
    return controller;
}

+ (void)target_showAlert:(NSString *)title
                 content:(NSString *)content
            sureCallback:(dispatch_block_t)sureCallback {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:content message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureCallback) {
            sureCallback();
        }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
