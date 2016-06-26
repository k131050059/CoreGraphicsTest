//
//  ViewController.m
//  CoreGraphicsTest
//
//  Created by jinlong sheng on 16/6/15.
//  Copyright © 2016年 sjl. All rights reserved.
//

#import "ViewController.h"

#define columnarHeight 145

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ColumnarView : UIView
@property (nonatomic,strong) NSArray *valueArray;
@property (nonatomic,assign) double maxMoney;
@property (nonatomic,assign) int changeBlue; //定义为从左往右数第changeBlue个为当前月
@property (nonatomic,assign) int startMonth;
@end

@implementation ColumnarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
   
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);//转换坐标原点
    for (int index=0 ; index<self.valueArray.count; index++) {
        NSNumber *numb =  [_valueArray objectAtIndex:index];
        NSInteger height=0;
        float xPosition= 0;
        height = numb.integerValue/(_maxMoney/(columnarHeight-5));
        if (index>self.changeBlue) {
            height=15;
        }
        
        xPosition = 19+index*9 +14*index;
        if (height>0) {
            NSArray *backgroundColors=[[NSArray alloc]init];
            if(index==self.changeBlue){
                backgroundColors  = @[ (id)[[UIColor colorWithRed:98.0/255.0 green:186.0/255.0 blue:129.0/255.0 alpha:1] CGColor],
                                       (id)[[UIColor colorWithRed:67.0/255.0 green:183.0/255.0 blue:228.0/255.0 alpha:1] CGColor],
                                       ];
            }else if(index<self.changeBlue){
                backgroundColors  = @[ (id)[[UIColor colorWithRed:252.0/255.0 green:134.0/255.0 blue:108.0/255.0 alpha:1] CGColor],
                                       (id)[[UIColor colorWithRed:252.0/255.0 green:165.0/255.0 blue:56.0/255.0 alpha:1] CGColor],
                                       ];
            }else{
                backgroundColors  = @[ (id)[[UIColor colorWithRed:254.0/255.0 green:213.0/255.0 blue:91.0/255.0 alpha:1] CGColor],
                                       (id)[[UIColor colorWithRed:254.0/255.0 green:213.0/255.0 blue:91.0/255.0 alpha:1] CGColor],
                                       ];
                
            }
            
            CGFloat backgroudColorLocations[2] = {1.0f, 0.0f};
            CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
            CGGradientRef backgroundGradient = CGGradientCreateWithColors(rgb, (__bridge CFArrayRef)(backgroundColors), backgroudColorLocations);
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, xPosition, 5);
            CGContextAddLineToPoint(context,xPosition,height-4.5);
            CGContextAddArcToPoint(context, xPosition, height, xPosition+4.5, height, 2);
            CGContextAddArcToPoint(context, xPosition+9, height, xPosition+9, height-4.5, 2);
            CGContextAddLineToPoint(context, xPosition+9, 5);
            CGContextClosePath(context);
            CGContextClip(context);
            
            
            CGContextDrawLinearGradient(context,
                                        backgroundGradient,
                                        CGPointMake(xPosition ,5),
                                        CGPointMake(xPosition ,height+5),
                                        0);
            CGGradientRelease(backgroundGradient);
            CGColorSpaceRelease(rgb);
            CGContextRestoreGState(context);
            
            CGPoint aPoints[2];//坐标点
            aPoints[0] =CGPointMake(xPosition+4.5, 4);
            aPoints[1] =CGPointMake(xPosition+4.5, 0);
            CGContextSetRGBStrokeColor(context,168/255,175/255,178/255,0.2);
            CGContextAddLines(context, aPoints, 2);//添加线
            CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
            
            if (index<=self.changeBlue) {
                UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(xPosition-11, self.bounds.size.height-height-18, 30, 20)];
                lab.textAlignment=NSTextAlignmentCenter;
                lab.font=[UIFont systemFontOfSize:10];
                lab.backgroundColor=[UIColor clearColor];
                lab.text=[NSString stringWithFormat:@"￥%ld",(long)height];
                if (index==self.changeBlue) {
                    lab.textColor=UIColorFromRGB(0x62ba81);
                }else{
                    lab.textColor=UIColorFromRGB(0xf55a5a);
                }
                [self addSubview:lab];
            }
            
            
            UILabel *month=[[UILabel alloc]initWithFrame:CGRectMake(xPosition-11, self.bounds.size.height-2, 30, 20)];
            month.textAlignment=NSTextAlignmentCenter;
            month.font=[UIFont systemFontOfSize:10];
            month.backgroundColor=[UIColor clearColor];
            int mstr=self.startMonth+index;
            if (mstr>12) {
                mstr=mstr-12;
            }
            if (mstr<10) {
                month.text=[NSString stringWithFormat:@"0%d",mstr];
            }else{
                month.text=[NSString stringWithFormat:@"%d",mstr];
            }
            
            if (index==self.changeBlue) {
                month.textColor=UIColorFromRGB(0x43b7e4);
            }else{
                month.textColor=UIColorFromRGB(0xfc9d46);
            }
            [self addSubview:month];
            
            
        }
    }
}
@end

@interface testView : UIView

@end
@implementation testView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    //绘制矩形
    [self drawRectangle];
    //绘制椭圆
    [self drawEllipse];
    
 
}
//绘制椭圆
- (void)drawEllipse {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
 
    CGRect rectangle = CGRectMake(20,10, 30, 20);
    
    // 在当前路径下添加一个椭圆路径
    CGContextAddEllipseInRect(ctx, rectangle);
    
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    
 
    CGContextFillPath(ctx);
}
//绘制矩形
- (void)drawRectangle {
    CGRect rectange = CGRectMake(0, 0, 10, 10);
    //获取当前画布
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx, rectange);
    
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextFillPath(ctx);
}

@end

@interface ViewController (){
    ColumnarView *cView; ///柱状图
    testView *tView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cView =[[ColumnarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, columnarHeight)];
    cView.maxMoney=140;
    cView.backgroundColor=[UIColor clearColor];
    cView.changeBlue=3;
    cView.startMonth=6;
    cView.valueArray=@[@(111),@(40),@(41),@(134),@(63),@(97),@(84),@(108),@(79),@(11),@(11),@(11),@(11) ];
//    [cView setNeedsDisplay];
    [self.view addSubview:cView];

    tView=[[testView alloc]initWithFrame:CGRectMake(0, columnarHeight+10, self.view.frame.size.width, self.view.frame.size.height-columnarHeight)];
    tView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tView];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
