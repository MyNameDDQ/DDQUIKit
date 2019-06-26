//
//  DDQWebViewController.h
//  DDQUIKit
//
//  Created by 我叫咚咚枪 on 2019/3/27.
//  Copyright © 2019 我叫咚咚枪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_AVAILABLE_IOS(1_0_1)
@interface DDQWebViewController : UIViewController

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
@property (nonatomic, readonly, strong) WKWebView *WKWebView;
#else
@property (nonatomic, readonly, strong) UIWebView *webView;
#endif

@end

NS_ASSUME_NONNULL_END
