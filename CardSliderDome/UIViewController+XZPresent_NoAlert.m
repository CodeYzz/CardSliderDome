//
//  UIViewController+XZPresent_NoAlert.m
//  CardSliderDome
//
//  Created by yanzz on 2021/6/28.
//  Copyright © 2021 mobile. All rights reserved.
//

#import "UIViewController+XZPresent_NoAlert.h"
#import <objc/runtime.h>

@implementation UIViewController (XZPresent_NoAlert)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(xz_presentViewController:animated:completion:));
        
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
    
    
    
}

- (void)xz_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        }
    }
    
    [self xz_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
