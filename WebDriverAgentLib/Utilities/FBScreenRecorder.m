//
//  FBScreenRecorder.m
//  WebDriverAgentLib
//
//  Created by Sidharth J Dev on 08/03/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "FBScreenRecorder.h"
#import <ReplayKit/ReplayKit.h>

@interface FBScreenRecorder () <RPPreviewViewControllerDelegate>

@property (nonatomic, strong) RPScreenRecorder *screenRecorder;

@end

@implementation FBScreenRecorder

+ (instancetype)sharedRecorder {
    static FBScreenRecorder *sharedRecorder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRecorder = [[self alloc] init];
    });
    return sharedRecorder;
}

- (instancetype)init {
    if (self = [super init]) {
        _screenRecorder = [RPScreenRecorder sharedRecorder];
    }
    return self;
}

- (BOOL)startRecordingWithError:(NSError **)error {
    if (!self.screenRecorder.isAvailable) {
        if (error) {
            *error = [NSError errorWithDomain:@"FBScreenRecorderErrorDomain" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Screen recording is not available."}];
        }
        return NO;
    }
    
    [self.screenRecorder startRecordingWithHandler:^(NSError * _Nullable startError) {
        if (startError) {
            NSLog(@"Failed to start screen recording: %@", startError.localizedDescription);
            if (error) {
                *error = startError;
            }
        } else {
            NSLog(@"Screen recording started successfully.");
        }
    }];
    
    return YES;
}

- (void)stopRecordingWithCompletion:(void(^)(RPPreviewViewController *previewViewController, NSError *error))completion {
    [self.screenRecorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable stopError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (stopError) {
                NSLog(@"Failed to stop screen recording: %@", stopError.localizedDescription);
                if (completion) {
                    completion(nil, stopError);
                }
            } else {
                NSLog(@"Screen recording stopped successfully.");
                if (previewViewController) {
                    previewViewController.previewControllerDelegate = self;
                }
                if (completion) {
                    completion(previewViewController, nil);
                }
            }
        });
    }];
}

#pragma mark - RPPreviewViewControllerDelegate

- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    [previewController dismissViewControllerAnimated:YES completion:^{}];
    // Here you can handle further actions after the preview is dismissed.
}

@end
