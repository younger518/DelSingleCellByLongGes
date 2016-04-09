//
//  YNTableViewCell.h
//  DelSingleCellByLongGes
//
//  Created by yangneng on 16/4/9.
//  Copyright © 2016年 yangneng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDataObject.h"

@interface YNTableViewCell : UITableViewCell

-(void)bindDataWithObject:(MDataObject *)obj;
@end
