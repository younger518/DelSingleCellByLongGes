//
//  ViewController.m
//  DelSingleCellByLongGes
//
//  Created by yangneng on 16/4/9.
//  Copyright © 2016年 yangneng. All rights reserved.
//

#import "ViewController.h"
#import "YNTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(nonatomic,strong) NSMutableArray *testDataArray;
@property(nonatomic,assign) NSInteger pressedRow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *edViewHeightCons;
@property (weak, nonatomic) IBOutlet UIView *editView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ///
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///懒加载
-(NSMutableArray *)testDataArray{
    if (_testDataArray == nil) {
        _testDataArray = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            MDataObject *obj = [[MDataObject alloc]init];
            obj.mTitle = [NSString stringWithFormat:@"title%d",i];
            obj.mSubTitle = [NSString stringWithFormat:@"subTitle%d",i];
            [_testDataArray addObject:obj];
        }
        
    }
    return _testDataArray;
}
-(void)initData{
    self.pressedRow = -1;
    self.edViewHeightCons.constant = 0;
    self.editView.hidden = YES;
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YNTableViewCell"];
    if (cell == nil) {
        cell = [[YNTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YNTableViewCell"];
    }
    MDataObject *data = [self.testDataArray objectAtIndex:indexPath.row];
    [cell bindDataWithObject:data];
    
    ////添加长按手势
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressedOnCell:)];
    [cell addGestureRecognizer:longGes];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == self.pressedRow) {
        NSLog(@"----------canEditRowAtIndexPath------");
        return YES;
    }else{
        return NO;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--------------------%ld",indexPath.row);
}


-(void)longPressedOnCell:(UILongPressGestureRecognizer *)longPressGes{
    YNTableViewCell *cell = (YNTableViewCell *)longPressGes.view;
    NSIndexPath *longPressIndexPath = [self.mTableView indexPathForCell:cell];
    self.pressedRow = longPressIndexPath.row;
    [self.mTableView setEditing:YES animated:YES];
    self.editView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.edViewHeightCons.constant = 60;
    }];
    //NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:self.pressedRow inSection:0];
    //[self.mTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)confirmDelete:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:[NSString stringWithFormat:@"你删除的数据是第 %ld 的数据",self.pressedRow] preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self hideEditView];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self hideEditView];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
}

-(void)hideEditView{
    self.pressedRow = -1;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.edViewHeightCons.constant = 0;
    }completion:^(BOOL finished) {
        self.editView.hidden = YES;
        [self.mTableView setEditing:NO animated:YES];
    }];
}
- (IBAction)cancelDelete:(id)sender {
    [self hideEditView];
}











@end
