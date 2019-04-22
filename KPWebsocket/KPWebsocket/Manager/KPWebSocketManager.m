//
//  KPWebSocketManager.m
//  KPWebsocket
//
//  Created by Soul on 2019/4/22.
//  Copyright © 2019 McStudio. All rights reserved.
//

#import "KPWebSocketManager.h"
#import <MJExtension/MJExtension.h>

@interface KPWebSocketManager ()

@property (nonatomic, strong) SRWebSocket *webSocket;

@end

@implementation KPWebSocketManager

+ (instancetype)shareInstance {
    static dispatch_once_t token;
    static KPWebSocketManager *manger = nil;
    dispatch_once(&token, ^{
        manger = [[KPWebSocketManager alloc] init];
        [manger initWsConfigure];
    });
    return manger;
}

#pragma - 操作
- (void)initWsConfigure {
    NSURL *wsUrl = [NSURL URLWithString:@"wss://www.opt.hague.tech/api/em/socket/csq"];
    self.webSocket = [[SRWebSocket alloc] initWithURL:wsUrl];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;//zc read:并发数为1==>串行队列
    [self.webSocket setDelegateOperationQueue:queue];
    self.webSocket.delegate = self;
}

- (void)connect {
    if (self.webSocket.readyState == SR_CONNECTING) {
        NSLog(@"第一次开启ws:%ld",self.webSocket.readyState);
        [self.webSocket open];
    } else {
        NSLog(@"已经开启ws:%ld,不可重复开启",self.webSocket.readyState);
    }
}

- (void)disconnect {
    if (self.webSocket.readyState != SR_CLOSED) {
        NSLog(@"准备关闭ws");
        [self.webSocket close];
    }
}

- (void)send:(NSDictionary *)jsonPara {
    if (self.webSocket.readyState != SR_OPEN) {
        [self connect];
    }
    
    id para = [jsonPara mj_JSONObject];
    [self.webSocket send:para];
}

#pragma - 回调

- (void)webSocket:(SRWebSocket *)webSocket
didReceiveMessage:(id)message {
    
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"websocket Open成功");
}

- (void)webSocket:(SRWebSocket *)webSocket
 didFailWithError:(NSError *)error {
    
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason
         wasClean:(BOOL)wasClean {
     NSLog(@"websocket close...%@",reason);
}

- (void)webSocket:(SRWebSocket *)webSocket
   didReceivePong:(NSData *)pongPayload{
    
}

// Return YES to convert messages sent as Text to an NSString. Return NO to skip NSData -> NSString conversion for Text messages. Defaults to YES.
- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket{
    return YES;
}

@end
