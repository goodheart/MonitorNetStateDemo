//
//  PMNetMonitor.h
//  MonitorNetStateDemo
//
//  Created by majian on 15/10/14.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * PMNetMonitorNetStateNotification;

typedef NS_ENUM(NSUInteger,PMNetMonitorNetState) {
    PMNetMonitorNetStateNotReach = 0, //不能连接
    PMNetMonitorNetStateMobileData, //2G/3G/4G
    PMNetMonitorNetStateWifi, //Wifi环境
};

@interface PMNetMonitor : NSObject
/* 使用网络状态的情况
    1、网络状态改变        通过通知监听
    2、进入某个页面判断网路 提供接口，用的时候调用
 */
- (void)startMonitor;
- (void)stopMonitor;
@property (nonatomic,assign,readonly) PMNetMonitorNetState netState;

@end
