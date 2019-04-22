//
//  KPWebSocketManager.h
//  KPWebsocket
//
//  Created by Soul on 2019/4/22.
//  Copyright © 2019 McStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>

NS_ASSUME_NONNULL_BEGIN

@interface KPWebSocketManager : NSObject<SRWebSocketDelegate>

@property (nonatomic, strong, readonly) SRWebSocket *webSocket;

+ (instancetype)shareInstance;

- (void)connect;

- (void)disconnect;

- (void)send:(NSDictionary *)jsonPara;

@end

NS_ASSUME_NONNULL_END
