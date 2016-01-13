//
//  TipsView.m
//  TipsView
//
//  Created by Johnson on 1/12/16.
//  Copyright © 2016 Johnson. All rights reserved.
//

#import "TipsView.h"

#define AppDelegateWindow  [[[UIApplication sharedApplication] delegate] window]

#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height

#define Tag                   789
#define BackgroundMarginMin   66   //左右最小间距和
#define HorizontalTextMargin(showType)         (showType == ShowTypeCenter ? 22 : 11)
#define VerticalTextMargin(showType)           (showType == ShowTypeCenter ? 16 :  8)
#define TextNumberOfLines(showType)            (showType == ShowTypeCenter ? 5 :  2)
#define TextFont(showType)                     (showType == ShowTypeCenter ? 16 :  12)

#define BottomMargin          66   //距离底部间距

typedef NS_ENUM(NSInteger, ShowType)
{
    ShowTypeCenter,
    ShowTypeBottom,
};


@implementation TipsView
{
    UILabel *_labelTitle;
    BOOL _showType;
    void(^_completion)(void);
}


+ (void)showCenterTitle:(NSString *)title;
{
    [TipsView showCenterTitle:title completion:nil];
}

+ (void)showCenterTitle:(NSString *)title completion:(void(^)(void))completion;
{
    [TipsView showCenterTitle:title duration:1.5f completion:completion];
}

+ (void)showCenterTitle:(NSString *)title duration:(NSTimeInterval)duration completion:(void(^)(void))completion;
{
    [TipsView showTitle:title duration:duration showType:ShowTypeCenter completion:completion];
}


+ (void)showBottomTitle:(NSString *)title;
{
    [TipsView showBottomTitle:title completion:nil];
}

+ (void)showBottomTitle:(NSString *)title completion:(void(^)(void))completion;
{
    [TipsView showBottomTitle:title duration:1.5f completion:completion];
}

+ (void)showBottomTitle:(NSString *)title duration:(NSTimeInterval)duration completion:(void(^)(void))completion;
{
    [TipsView showTitle:title duration:duration showType:ShowTypeBottom completion:completion];
}


+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration showType:(ShowType)showType completion:(void(^)(void))completion;
{
    
    TipsView *tipsView = [AppDelegateWindow viewWithTag:Tag];
    if (!tipsView) {
        tipsView = [[[self class] alloc] init];
        tipsView.tag = Tag;
        [AppDelegateWindow addSubview:tipsView];
    }
    
    [tipsView setTiltle:title show:showType completion:completion];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:tipsView];
    [tipsView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:duration];
}

+ (void)dismiss;
{
    TipsView *tipsView = [AppDelegateWindow viewWithTag:Tag];
    [[self class] cancelPreviousPerformRequestsWithTarget:tipsView];
    
    if (tipsView) { tipsView->_showType = ShowTypeBottom; }  //绕过缩小动画
    [tipsView removeFromSuperview];
}


- (void)dealloc
{
    _labelTitle = nil;
    _completion = nil;
    NSLog(@"释放了, 写写总是好的");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.layer.cornerRadius = 5.f;
        
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:_labelTitle];
    }
    return self;
}

- (void)setTiltle:(NSString *)title show:(ShowType)showType completion:(void(^)(void))completion;
{
    _showType = showType;
    _completion = completion;
    
    _labelTitle.numberOfLines = TextNumberOfLines(showType);
    _labelTitle.font = [UIFont systemFontOfSize:TextFont(showType) - (ScreenWidth == 320 ? 1 : 0)];
    
    _labelTitle.text = title;
    _labelTitle.frame = CGRectMake(0, 0, ScreenWidth - BackgroundMarginMin - HorizontalTextMargin(showType), 0);
    [_labelTitle sizeToFit];
    
    CGRect rect = _labelTitle.bounds;
    rect.size.width = rect.size.width + HorizontalTextMargin(showType);
    rect.size.height = rect.size.height + VerticalTextMargin(showType);
    self.bounds = rect;
    self.center = showType == ShowTypeBottom ? CGPointMake(ScreenWidth / 2, ScreenHeight - BottomMargin) : CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    
    _labelTitle.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

- (void)removeFromSuperview
{
    if (_showType == ShowTypeCenter) {
        [UIView animateWithDuration:0.25f animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                _completion ? _completion() : nil;
                [super removeFromSuperview];
            }];
        }];
    }else {
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            _completion ? _completion() : nil;
            [super removeFromSuperview];
        }];
    }
}

@end
