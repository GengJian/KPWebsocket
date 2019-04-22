//
//  ViewController.m
//  KPWebsocket
//
//  Created by Soul on 2019/4/22.
//  Copyright © 2019 McStudio. All rights reserved.
//

#import "ViewController.h"
#import "KPWebSocketManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)connectClicked:(id)sender {
    [[KPWebSocketManager shareInstance] connect];
}

- (IBAction)disconnectClicked:(id)sender {
    [[KPWebSocketManager shareInstance] disconnect];
}

- (IBAction)subscribeAll:(id)sender {
    NSDictionary *dict = @{
                           "m": "csq",      // method 方法
                           "d": @{           // data 数据 参数
                                   "reset": 0,     // 1 为取消之前订阅的所有 code
                                   "codes": [""]   // 新增订阅的股票代码
                                   }
                           };
    [[KPWebSocketManager shareInstance] send:dict];
}

- (IBAction)subscribeSingle:(id)sender {
    
}

@end
