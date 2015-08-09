//
//  HTTPRequest.h
//  请求类封装Demo
//
//  Created by vera on 15/7/26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@class HTTPRequest;

@protocol HTTPRequestDelegate <NSObject>

//自定义的协议方法默认都是@required
@optional
//请求完成的回调
- (void)requestDidFinish:(HTTPRequest *)request;
//请求失败的回调
- (void)requestDidError:(NSError *)error;

//进度的回调
- (void)requestDidProgress:(CGFloat)progress;

@end

/**
 请求类
 */
@interface HTTPRequest : NSObject

@property (nonatomic, assign) id<HTTPRequestDelegate> delegate;

//保存数据
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, copy) NSString *responseString;

@property(nonatomic,assign) long long begin;
@property(nonatomic,assign) long long currentLength;
@property(nonatomic,assign) long long end;




/**
 构造方法
 */
- (id)initWithUrl:(NSURL *)url;

/**
 开始请求
 */
- (void)startRequest;

@end
