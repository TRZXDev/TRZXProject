//
//  TRZXHotProjectViewController.m
//  TRZXProject
//
//  Created by N年後 on 2017/2/21.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXHotProjectViewController.h"
#import "TRZXProjectViewModel.h"
#import "TRZXProjectCell.h"
#import "TRZXKit.h"
@interface TRZXHotProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *hotProjectTableView;
@property (strong, nonatomic) TRZXProjectViewModel *projectViewModel;

@end

@implementation TRZXHotProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.hotProjectTableView];

    [self requestSignal_hotProject];

    // Do any additional setup after loading the view.
}


// 发起请求
- (void)requestSignal_hotProject {


    [self.projectViewModel.requestSignal_hotProject subscribeNext:^(id x) {

        // 请求完成后，更新UI
        [self.hotProjectTableView reloadData];

    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _projectViewModel.listArray.count;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TRZXProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TRZXProjectCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier_TRZXProjectCell owner:self options:nil] lastObject];
    }

    TRZXProject *project = [_projectViewModel.listArray objectAtIndex:indexPath.row];
    cell.project = project;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];



}


-(UITableView *)hotProjectTableView{
    if (!_hotProjectTableView) {
        // 内容视图
        _hotProjectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _hotProjectTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-158);
        _hotProjectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotProjectTableView.dataSource = self;
        _hotProjectTableView.delegate = self;
        _hotProjectTableView.estimatedRowHeight = 103;  //  随便设个不那么离谱的值
        _hotProjectTableView.rowHeight = UITableViewAutomaticDimension;
        // 去除顶部空白
        _hotProjectTableView.tableHeaderView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];;
        _hotProjectTableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];;

    }
    return _hotProjectTableView;
}
- (TRZXProjectViewModel *)projectViewModel {

    if (!_projectViewModel) {
        _projectViewModel = [TRZXProjectViewModel new];
    }
    return _projectViewModel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
