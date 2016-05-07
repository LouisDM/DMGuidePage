//
//  DMGudiePageViewController.h
//  GuidePage
//
//  Created by gdm on 16/5/7.
//  Copyright © 2016年 辜东明. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

@interface DMGudiePageViewController : UIViewController

typedef NS_ENUM(NSInteger,ImageType) {
    ImageName = 0,
    ImageUrlStr
};

/**
 *  引导页
 *
 *  @param imageType        图片类型
 *  @param imageArr         图片数组
 *  @param cuColor          当前进度点颜色
 *  @param otColor          其他进度点颜色
 *  @param didSelectedEnter 进入执行的代码块
 *
 *  @return self
 */
-(instancetype)initWithImageType:(ImageType)imageType andImageArr:(NSArray*)imageArr andCurrentPageColor:(UIColor *)cuColor andOtherPageColor:(UIColor *)otColor andDidSelectedEnter:(DidSelectedEnter)didSelectedEnter;


@end
