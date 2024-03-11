//
//  FBScreenRecorder.h
//  WebDriverAgent
//
//  Created by Sidharth J Dev on 08/03/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBScreenRecorder : NSObject

+ (instancetype)sharedRecorder;

- (BOOL)startRecordingWithError:(NSError **)error;
- (NSData *)stopRecordingWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
