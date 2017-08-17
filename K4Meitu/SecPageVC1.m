//
//  SecPageVC1.m
//  K4Meitu
//
//  Created by simpleem on 7/6/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageVC1.h"
#import "Header.h"
#import "ThirdTujianCell.h"
#import "ThirdTujianMutiPicCell.h"
@interface SecPageVC1 ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;


@end

@implementation SecPageVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self initTableView];
    
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ThirdTujianCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ThirdTujianMutiPicCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 != 0) {
        return 100;
    }else{
        return 145;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row % 2 != 0) {
        ThirdTujianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[ThirdTujianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSString *str = @"本文为博主原创文章，未经博主允许不得转载";
        
        cell.Title.text = [str stringByAppendingString:@"\n"];
        
        return cell;
    }else{
        ThirdTujianMutiPicCell *mutiPicCell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (mutiPicCell == nil) {
            mutiPicCell = [[ThirdTujianMutiPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        NSString *str = @"以上用户言论只代表其个人观点，不代表CSDN网站的观点或立场";
        //mutiPicCell.img_2.frame = CGRectMake((IPHONE_WIDTH - IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118)/2, CGRectGetMaxY(mutiPicCell.Title.frame), IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 70);
        
        mutiPicCell.Title.text = [str stringByAppendingString:@"\n"];
        
        mutiPicCell.img_1.frame = CGRectMake(IPHONE_WIDTH<=375?8:(IPHONE_WIDTH-119*3)/2, CGRectGetMaxY(mutiPicCell.Title.frame)+10,  IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 75);
        
        mutiPicCell.img_2.frame = CGRectMake(CGRectGetMaxX(mutiPicCell.img_1.frame)+1, CGRectGetMaxY(mutiPicCell.Title.frame)+10,  IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 75);
        
        mutiPicCell.img_3.frame = CGRectMake(CGRectGetMaxX(mutiPicCell.img_2.frame)+1, CGRectGetMaxY(mutiPicCell.Title.frame)+10,  IPHONE_WIDTH<=375?(IPHONE_WIDTH-18)/3:118, 75);
        return mutiPicCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)dealloc{
    NSLog(@"controller-(推荐)-已经释放");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
