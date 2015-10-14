//
//  PMNetMonitor.m
//  MonitorNetStateDemo
//
//  Created by majian on 15/10/14.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMNetMonitor.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

NSString * PMNetMonitorNetStateNotification = @"PMNetMonitorNetStateNotification";

@interface PMNetMonitor ()
@property (nonatomic,strong) Reachability * reachability;
@property (nonatomic,assign) PMNetMonitorNetState  netState;
@end

@interface PMNetMonitor (PrivateMethod )

- (void)netStateChanged:(NSNotification *)notification;
- (void)sysWillTerminal;

@end

@implementation PMNetMonitor
#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _reachability = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
        _netState = 4;//表示当前还没有状态
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(netStateChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sysWillTerminal)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [_reachability stopNotifier];
    _reachability = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public Method
- (void)startMonitor {
    [_reachability startNotifier];
}

- (void)stopMonitor {
    [_reachability stopNotifier];
}

@end

@implementation PMNetMonitor (PrivateMethod)
static BOOL isPosted = NO;
- (void)netStateChanged:(NSNotification *)notification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC), dispatch_get_global_queue(0, 0), ^{
        if (YES == isPosted) {
            isPosted = NO;  //这样设置可以保证1.0秒之内执行一次Post
        }
    });

    if (NO == isPosted) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PMNetMonitorNetStateNotification
                object:@([self.reachability currentReachabilityStatus])];
        isPosted = YES;
    }
}

- (void)sysWillTerminal {
    [_reachability stopNotifier];
}

@end






