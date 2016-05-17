//
//  locationPicker.h
//  Run
//
//  Created by  陈庆笑 on 16/2/29.
//  Copyright © 2016年 cqx.lanqiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMGroup;
@interface LocationPicker : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic)  NSMutableArray *province;
@property (nonatomic)  NSMutableArray *city;
@property (nonatomic)  NSMutableArray *curCity;

@property (nonatomic) IMGroup* group;

@end
