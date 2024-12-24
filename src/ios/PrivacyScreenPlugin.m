/*
 * PrivacyScreenPlugin.m
 * Created by Tommy-Carlos Williams on 18/07/2014
 * Copyright (c) 2014 Tommy-Carlos Williams. All rights reserved.
 * MIT Licensed
 */
#import "AppDelegate.h"
#import "MainViewController.h"
#import "PrivacyScreenPlugin.h"

static UIImageView *imageView;
static UITextField *secureField;
static BOOL enabled = false;

@implementation PrivacyScreenPlugin

- (void)pluginInitialize {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

// on app becoming active again, remove any black layers in front of it
- (void)onAppDidBecomeActive:(UIApplication *)application {
    // self.viewController.view.window.hidden = NO;
    if (imageView != NULL) {
        [imageView removeFromSuperview];
        imageView = NULL;
    }
}

// if privacy is enabled, on app becoming inactive the view is blocked out by disabling the view,
// or by putting a black layer in front of it
- (void)onAppWillResignActive:(UIApplication *)application {
    if (enabled) {
        // self.viewController.view.window.hidden = YES;

        // create a black image, then put it in front of the app view
        CGSize imageSize = CGSizeMake(64, 64);
        UIColor *fillColor = [UIColor blackColor];
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [fillColor setFill];
        CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        imageView = [[UIImageView alloc]initWithFrame:[self.viewController.view bounds]];
        [imageView setImage:image];

        #ifdef __CORDOVA_4_0_0
            [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        #else
            [self.viewController.view addSubview:imageView];
        #endif
    }
}

- (void)createSecureLayer {
    // generate a layer with massive text input field
    // when field.secureTextEntry is YES, screenshots of the input gets blacked out, so entire app gets blacked out
    UIWindow *window = [[[[UIApplication sharedApplication] delegate] window] rootViewController].view.window;

    UITextField *field = [[UITextField alloc] init];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, field.frame.size.width, field.frame.size.height)];

    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteImage"]];
    image.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    field.secureTextEntry = NO;

    [window addSubview:field];
    [view addSubview:image];

    [window.layer.superlayer addSublayer:field.layer];
    [[field.layer.sublayers lastObject] addSublayer:window.layer];

    field.leftView = view;
    field.leftViewMode = UITextFieldViewModeAlways;

    secureField = field;
}

- (void) onAppDidFinishLaunching:(NSNotification *)notification {
    [self createSecureLayer];
}

- (void)enable:(CDVInvokedUrlCommand*)command {
    // NSLog(@"PrivacyScreenPlugin enabled");
    enabled = true;

    if (secureField != NULL) {
        secureField.secureTextEntry = YES;
    }

    CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: @"PrivacyScreenPlugin enabled"];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)disable:(CDVInvokedUrlCommand*)command {
    // NSLog(@"PrivacyScreenPlugin disabled");
    enabled = false;

    if (secureField != NULL) {
        secureField.secureTextEntry = NO;
    }

    CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: @"PrivacyScreenPlugin disabled"];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end