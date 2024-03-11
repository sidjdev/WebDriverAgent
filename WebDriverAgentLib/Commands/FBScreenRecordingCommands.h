//
//  FBScreenRecordingCommands.h
//  WebDriverAgent
//
//  Created by Sidharth J Dev on 08/03/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebDriverAgentLib/FBCommandHandler.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBScreenRecordingCommands : NSObject <FBCommandHandler>

+ (id<FBResponsePayload>)handleStartScreenRecording:(FBRouteRequest *)request;
+ (id<FBResponsePayload>)handleStopScreenRecording:(FBRouteRequest *)request;

@end

NS_ASSUME_NONNULL_END
