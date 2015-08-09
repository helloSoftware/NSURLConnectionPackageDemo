//
//  ViewController.m
//  请求类封装Demo
//
//  Created by vera on 15/7/26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "ViewController.h"
#import "HTTPRequest.h"

@interface ViewController ()<HTTPRequestDelegate>

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

/**
 加载指示器
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

/**
 进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**
 显示进度百分比
 */
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
- (IBAction)pauseClick:(id)sender;
- (IBAction)downloadClick:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = @"http://assets.sbnation.com/assets/2512203/dogflops.gif";
    
    //请求类
    HTTPRequest *request = [[HTTPRequest alloc] initWithUrl:[NSURL URLWithString:urlString]];
    request.delegate = self;
    //开始异步下载
    [request startRequest];
    
    //开启转动
    [_indicatorView startAnimating];

}

#pragma mark - HTTPRequestDelegate
//请求完成的回调
- (void)requestDidFinish:(HTTPRequest *)request
{
    //停止转动
    [_indicatorView stopAnimating];
    
    //图片替换
    _photoView.image = [UIImage imageWithData:request.responseData];
}

//请求失败的回调
- (void)requestDidError:(NSError *)error
{
    //停止转动
    [_indicatorView stopAnimating];
}

//进度的回调
- (void)requestDidProgress:(CGFloat)progress
{
    //更新界面
    
    //进度
    _progressView.progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(progress*100)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pauseClick:(id)sender {
    
    
    
}

- (IBAction)downloadClick:(id)sender {
    
    
}
@end
