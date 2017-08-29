//
//  ArticleLatestDetailVC.m
//  K4Meitu
//
//  Created by simpleem on 8/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "ArticleLatestDetailVC.h"
#import "Header.h"
#import "MJRefresh.h"
#import "RequestManager.h"
@interface ArticleLatestDetailVC ()

@property (strong, nonatomic) UIScrollView *scroll;


@end

@implementation ArticleLatestDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White_COLOR;
    [self addBackButton:NO];
    [self addStatusBlackBackground];
    [self addTitleWithName:[NSString stringWithFormat:@"%@",self.articleModel.subType] wordNun:4];
    
    if (self.scroll == nil) {
        self.scroll = [[UIScrollView alloc] init];
    }
    self.scroll.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scroll];

    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, IPHONE_WIDTH-20, IPHONE_HEIGHT);
    label.font = [UIFont systemFontOfSize:15.0f];
    NSString *str = [NSString stringWithFormat:@"<font  style='font-size:17px'>%@</font>",self.articleModel.content];
    str = [str stringByReplacingOccurrencesOfString:@"<img" withString:@"<br"];
    str = [str stringByReplacingOccurrencesOfString:@"</div>" withString:@"</div><br>"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    label.attributedText=attrStr;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    CGFloat height = [label.attributedText boundingRectWithSize:CGSizeMake(IPHONE_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;

    
    [self.scroll addSubview:label];
    self.scroll.contentSize = CGSizeMake(IPHONE_WIDTH, height+64);
    
    
    [RequestManager getArticleLatestByType:@"性爱宝典" subType:@"性爱技巧" CurPage:@1 pCount:@10 success:^(NSData *data) {
        NSDictionary *dict = myJsonSerialization;
        NSLog(@"dict+++++++=%@",dict);
    } failed:^(NSError *error) {
        
    }];
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
