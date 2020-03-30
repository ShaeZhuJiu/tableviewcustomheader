//
//  HeaderView.h
//  CustomTableViewHeader
//
//  Created by 谢鑫 on 2019/5/31.
//  Copyright © 2019 Shae. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
+(instancetype)headerView;
@end

NS_ASSUME_NONNULL_END
