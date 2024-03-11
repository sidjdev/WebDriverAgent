//
//  FBScreenRecordingCommands.m
//  WebDriverAgentLib
//
//  Created by Sidharth J Dev on 08/03/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBScreenRecordingCommands.h"
#import <WebDriverAgentLib/FBRouteRequest.h>
#import <WebDriverAgentLib/FBSession.h>
#import <WebDriverAgentLib/FBScreenRecorder.h>

@implementation FBScreenRecordingCommands

+(NSArray *) routes {
  return
  @[
    [[FBRoute POST:@"/session/:sessionID/wda/screenrecord/start"] respondWithTarget:self action:@selector(handleStartScreenRecording:)],
    [[FBRoute POST:@"/session/:sessionID/wda/screenrecord/stop"] respondWithTarget:self action:@selector(handleStopScreenRecording:)],
  ];
}

+ (id<FBResponsePayload>)handleStartScreenRecording:(FBRouteRequest *)request
{
    NSError *error;
    if (![[FBScreenRecorder sharedRecorder] startRecordingWithError:&error]) {
        return FBResponseWithUnknownError(error);
    }
    return FBResponseWithOK();
}

+ (id<FBResponsePayload>)handleStopScreenRecording:(FBRouteRequest *)request
{
    NSError *error;
    NSData *videoData = [[FBScreenRecorder sharedRecorder] stopRecordingWithError:&error];
    if (error) {
        return FBResponseWithUnknownError(error);
    }
    return FBResponseWithObject(videoData);
}

@end
