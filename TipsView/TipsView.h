//
//  TipsView.h
//  TipsView
//
//  Created by Johnson on 1/12/16.
//  Copyright © 2016 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsView : UIView


+ (void)showCenterTitle:(NSString *)title;
+ (void)showCenterTitle:(NSString *)title completion:(void(^)(void))completion;
+ (void)showCenterTitle:(NSString *)title duration:(NSTimeInterval)duration completion:(void(^)(void))completion;

+ (void)showBottomTitle:(NSString *)title;
+ (void)showBottomTitle:(NSString *)title completion:(void(^)(void))completion;
+ (void)showBottomTitle:(NSString *)title duration:(NSTimeInterval)duration completion:(void(^)(void))completion;


+ (void)dismiss;

@end
