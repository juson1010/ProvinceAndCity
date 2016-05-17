//
//  ViewController.m
//  ProvinceAndCity
//
//  Created by cqx on 16/5/17.
//  Copyright © 2016年 cqx. All rights reserved.
//

#import "ViewController.h"
#import "CustomIOSAlertView.h"
#import "LocationPicker.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnSetLocation:(id)sender {
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确定", nil]];
    LocationPicker* pickerView = [[LocationPicker alloc] init];
    pickerView.dataSource = pickerView;
    pickerView.delegate = pickerView;
    [alertView setContainerView:pickerView];
    
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %ld.", buttonIndex, (long)[alertView tag]);
        if (buttonIndex == 0){
            
        }else{
            NSString* strLocation =  [NSString stringWithFormat:@"%@ - %@",[pickerView.province objectAtIndex:(long)[pickerView selectedRowInComponent:0]],[pickerView.curCity objectAtIndex:(long)[pickerView selectedRowInComponent:1]]];
            
            self.lblLocation.text = strLocation;
            
        }
        [alertView close];
    }];
    [alertView show];

}

@end
