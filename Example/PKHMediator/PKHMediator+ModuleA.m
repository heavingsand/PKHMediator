//
//  PanMediator+ModuleA.m
//  PanMediator
//
//  Created by Pan on 2020/10/29.
//

#import "PKHMediator+ModuleA.h"
#import <UIKit/UIKit.h>

@implementation PKHMediator (ModuleA)

- (UIViewController *)createController:(NSString *)title
                             backColor:(UIColor *)backColor {
    
    NSMutableArray *args = @[].mutableCopy;
    [args safaAddObject:title];
    [args safaAddObject:backColor];
    
    return [self pan_perform:@"ModuleA" action:@"target_createController:backColor:" args:args];
}

- (void)showAlert:(NSString *)title
          content:(NSString *)content
     sureCallback:(dispatch_block_t)sureCallback {
    
    NSMutableArray *args = @[].mutableCopy;
    [args safaAddObject:title];
    [args safaAddObject:content];
    [args safaAddObject:sureCallback];
    
    [self pan_perform:@"ModuleA" action:@"target_showAlert:content:sureCallback:" args:args];
}

@end
