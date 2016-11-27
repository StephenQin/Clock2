//
//  ViewController.m
//  sl时钟（新定时器）
//
//  Created by 秦－政 on 16/9/4.
//  Copyright © 2016年 pete. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockCD;
@property (nonatomic,weak) CALayer *secLayer;
@property (nonatomic,weak) CALayer *minLayer;
@property (nonatomic,weak) CALayer *houLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupTimer];
}

#pragma mark - 开启定时器
- (void)setupTimer
{
    // 创建对象
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    // 默认刷新频率为60次/秒  link.frameInterval = 20; 刷新频率变成60 / 20 次/秒；
    // 添加到运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
- (void)rotate
{
    // 计算旋转角度
    
    CGFloat angleS = M_PI * 2 / 60 / 60;
    CGFloat angleM = angleS / 60;
    CGFloat angleH = angleM / 60;
    // 设置旋转
    _secLayer.transform = CATransform3DRotate(_secLayer.transform, angleS, 0, 0, 1);
    
    _minLayer.transform = CATransform3DRotate(_minLayer.transform, angleM, 0, 0, 1);
    
    _houLayer.transform = CATransform3DRotate(_houLayer.transform, angleH, 0, 0, 1);

}
#pragma mark - 搭建界面
- (void)setupUI
{
    // 添加秒针
    CALayer *secondL = [self setupLayerWithBounds:CGRectMake(0, 0, 1, 75) andColor:[UIColor redColor] andPosition:CGPointMake(_clockCD.bounds.size.width * .5, _clockCD.bounds.size.height * .5) andAnchorPoint:CGPointMake(.5,.75)];
    // 分针
    CALayer *minuteL = [self setupLayerWithBounds:CGRectMake(0, 0, 1, 55) andColor:[UIColor redColor] andPosition:CGPointMake(_clockCD.bounds.size.width * .5, _clockCD.bounds.size.height * .5) andAnchorPoint:CGPointMake(.5,.75)];
    // 时针
    CALayer *hourteL = [self setupLayerWithBounds:CGRectMake(0, 0, 1, 45) andColor:[UIColor redColor] andPosition:CGPointMake(_clockCD.bounds.size.width * .5, _clockCD.bounds.size.height * .5) andAnchorPoint:CGPointMake(.5,.75)];
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取 时分秒
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    // 计算各个指针的起始角度
    CGFloat hourA = M_PI * 2 / 12 * components.hour;
    CGFloat minuteA = M_PI * 2 / 60 * components.minute;
    CGFloat secondA = M_PI * 2 / 60 * components.second;
    // 属性赋值
    _secLayer = secondL;
    _minLayer = minuteL;
    _houLayer = hourteL;
    // 设置各个指针的起始角度
    _houLayer.transform = CATransform3DRotate(_houLayer.transform, hourA, 0, 0, 1);
    _minLayer.transform = CATransform3DRotate(_minLayer.transform, minuteA, 0, 0, 1);
    _secLayer.transform = CATransform3DRotate(_secLayer.transform, secondA, 0, 0, 1);
    // 添加到表盘
    [_clockCD.layer addSublayer:secondL];
    [_clockCD.layer addSublayer:minuteL];
    [_clockCD.layer addSublayer:hourteL];

    
}
// 生成一个指针
- (CALayer*)setupLayerWithBounds:(CGRect)bounds andColor:(UIColor *)color andPosition:(CGPoint )position andAnchorPoint:(CGPoint)anchorPoint
{
    CALayer *ly = [CALayer layer];
    ly.bounds = bounds;
    ly.backgroundColor = color.CGColor;
    // 设置position
    ly.position = position;
    // 设置锚点
    ly.anchorPoint = anchorPoint;
    
    return ly;
}


@end
