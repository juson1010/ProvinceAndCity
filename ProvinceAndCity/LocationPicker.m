//
//  locationPicker.m
//  Run
//
//  Created by  陈庆笑 on 16/2/29.
//  Copyright © 2016年 cqx.lanqiao. All rights reserved.
//

#import "LocationPicker.h"



@interface LocationPicker()



@end
@implementation LocationPicker


- (NSString*) dataFilePath{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    return plistPath;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.province = [[NSMutableArray alloc] initWithCapacity:5];
        self.city = [[NSMutableArray alloc] initWithCapacity:5];
        self.curCity = [[NSMutableArray alloc] initWithCapacity:5];
        
        NSDictionary* areaDictionary = [[NSDictionary alloc] initWithContentsOfFile:[self dataFilePath]];
        NSEnumerator *enumerator1 = [areaDictionary objectEnumerator];
        id value1;
        while ((value1 = [enumerator1 nextObject])) {
            //add province
            NSLog(@"visit !");
            NSEnumerator *enumerator11 = [value1 keyEnumerator];
            id key11;
            while ((key11 = [enumerator11 nextObject])) {
                [self.province addObject:key11];
                NSLog(@" %@",key11);
            }
            
            NSMutableArray* tmpCity = [[NSMutableArray alloc] initWithCapacity:5];
            
            //add city
            NSEnumerator *enumerator12 = [value1 objectEnumerator];
            id value11;
            while ((value11 = [enumerator12 nextObject])) {
                
                NSEnumerator *enumerator112 = [value11 objectEnumerator];
                id value111;
                while ((value111 = [enumerator112 nextObject])) {
                    
                    NSEnumerator *enumerator1111 = [value111 keyEnumerator];
                    id key1111;
                    while ((key1111 = [enumerator1111 nextObject])) {
                        [tmpCity addObject:key1111];//每个省拥有的市
                    }//end of while key1111
                }//end of while value111
            }//end of while value11
            [self.city addObject:tmpCity];
        }
        
        self.curCity = [NSMutableArray arrayWithArray:[self.city objectAtIndex:0]];
    }
    return self;
}




#pragma mark- Picker Data Source Methods
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSLog(@"numberOfRowsInComponent -------------");
    if (component == 0) {
        NSLog(@"province count :%lu",(unsigned long)[self.province count]);
        return [self.province count];
        
    }
    else{
        NSLog(@"curCity count %lu",(unsigned long)[self.curCity count]);
        return [self.curCity count];
    }
    
}



#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        return [self.province objectAtIndex: row];
    }
    else {
        
        return [self.curCity objectAtIndex: row];
    }
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        [self.curCity removeAllObjects];
        //得到市的model的数组
        self.curCity = [NSMutableArray arrayWithArray:[self.city objectAtIndex:row]];
        
        //city
        [self selectRow: 0 inComponent: 1 animated: YES];
        //reload city
        [self reloadComponent: 1];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 80;
        //        return 100;
    }
    else {
        return 120;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [self.province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else  {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 120, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [self.curCity objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}



@end
