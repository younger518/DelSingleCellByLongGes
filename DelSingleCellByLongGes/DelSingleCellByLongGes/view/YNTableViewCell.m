//
//  YNTableViewCell.m
//  DelSingleCellByLongGes
//
//  Created by yangneng on 16/4/9.
//  Copyright © 2016年 yangneng. All rights reserved.
//

#import "YNTableViewCell.h"

@interface YNTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
@implementation YNTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"YNTableViewCell" owner:self options:nil][0];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindDataWithObject:(MDataObject *)obj{
    self.mTitleLabel.text = obj.mTitle;
    self.subTitleLabel.text = obj.mSubTitle;
}

@end
