//
//  HTTPRequest.m
//  请求类封装Demo
//
//  Created by vera on 15/7/26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    //请求地址
    NSURL *_url;
    
    //保存下载数据
    NSMutableData *_downloadData;
    
    //文件总大小
    long long _fileSizeBytes;
    
}

@end

@implementation HTTPRequest


/**
 构造方法
 */
- (id)initWithUrl:(NSURL *)url
{
    if (self = [super init])
    {
        _url = url;
        
        _downloadData = [NSMutableData data];
    }
    
    return self;
}

/**
 开始请求
 */
- (void)startRequest
{
    //请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    NSString *value = [NSString stringWithFormat:@"bytes=%lld-%lld",self.begin + self.currentLength, self.end];
   // [request setValue:value forHTTPHeaderField:@"Range"];
    
    //发送异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - 代理方法
#pragma mark -NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //清空数据
    _downloadData.length = 0;
    
    //获取文件总大小
    _fileSizeBytes = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //1.追加
    [_downloadData appendData:data];
    
    //2.计算进度
    float progess = (float)_downloadData.length / _fileSizeBytes;
    
    NSLog(@"%f",progess);
    
    //判断_delegate是否实现requestDidProgress:方法
    if ([_delegate respondsToSelector:@selector(requestDidProgress:)])
    {
        //进度的回调
        [_delegate requestDidProgress:progess];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //请求取消
    [connection cancel];
    
    //赋值
    _responseData = _downloadData;
    _responseString = [[NSString alloc] initWithData:_downloadData encoding:NSUTF8StringEncoding];
    
    
    if ([_delegate respondsToSelector:@selector(requestDidFinish:)])
    {
        //成功回调
        [_delegate requestDidFinish:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //请求取消
    [connection cancel];
    
    //错误回调
    if ([_delegate respondsToSelector:@selector(requestDidError:)])
    {
        [_delegate requestDidError:error];
    }
}


@end
