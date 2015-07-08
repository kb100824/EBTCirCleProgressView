//
//  EBTCircleProgressView.h
//  EBaoTongDai
//
//  Created by ebaotong on 15/7/2.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义圆形进度条
 */
@interface EBTCircleProgressView : UIView
/**
 *  圆形进度跳值0-1.0之间
 */
@property(nonatomic,assign)CGFloat progress;
/**
 *  圆形进度宽度
 */
@property(nonatomic,assign)CGFloat progressStorkeWidth;

/**
 *  圆形进度条填充颜色
 */
@property(nonatomic,strong)UIColor *progressStokeColor;

/**
 *  圆形进度条底部填充颜色
 */
@property(nonatomic,strong)UIColor *progressTrackStokeColor;

@end
