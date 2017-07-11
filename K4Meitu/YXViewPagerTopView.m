//
//  YXViewPagerTopView.m
//  Pods
//
//  Created by yixiang on 17/3/29.
//
//

#import "YXViewPagerTopView.h"
#import "YXViewPagerUtility.h"
#import "YXViewpagerItemViewModel.h"
#import "YXViewPagerTopItemView.h"
#import "Header.h"
@interface YXViewPagerTopView()<UIScrollViewDelegate,YXViewPagerTopItemViewDelegate>

@property (nonatomic, strong) NSMutableArray *tabViews;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) YXViewPagerTopViewTypeItemClickBlock itemClickBlock;

@end

@implementation YXViewPagerTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initMaskView];
        [self initTabScroller];
    }
    return self;
}

- (void)initMaskView{
    //设置长方块时
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    //设置底下画线
//    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 58, 60, 1)];
    _maskView.backgroundColor = [UIColor colorWithHexString:@"#FFEEAE"];
    [self addSubview:_maskView];
}

- (void)initTabScroller{
    _tabScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    _tabScroller.showsHorizontalScrollIndicator = NO;
    _tabScroller.backgroundColor = [UIColor clearColor];
    _tabScroller.bounces = NO;
    _tabScroller.delegate = self;
    [self addSubview:_tabScroller];
}

- (void)setMaskColor:(NSString *)maskColor{
    _maskView.backgroundColor = [UIColor colorWithHexString:maskColor];
}

- (void)renderUIWithArray:(NSArray *)dataArray{
    //如果数组为空
    if (ARRAY_IS_EMPTY(dataArray)) return;
    
    CGFloat offsetX = 0;
    CGFloat itemHeight = 60;
    [self handleItemWidthWithItemCount:dataArray.count];
    
    //底部线条时
//    _maskView.frame = CGRectMake(0, itemHeight-2, _itemWidth, 1);
    
    //长方块时蒙版的frame
    _maskView.frame = CGRectMake(0, 0, _itemWidth, self.height);
    
    _tabViews = [[NSMutableArray alloc] init];
    NSLog(@"dataArray.count======%lu",dataArray.count);
    for (int i=0; i<dataArray.count; i++) {
        NSLog(@"i======%d",i);
        
        YXViewPagerItemViewModel *model = dataArray[i];
        YXViewPagerTopItemView *itemView = [[YXViewPagerTopItemView alloc] initWithFrame:CGRectMake(offsetX, 0, _itemWidth, self.height)];
        itemView.delegate = self;
        [itemView renderUIWithViewModel:model];
        itemView.tag = i;
        [_tabScroller addSubview:itemView];
        offsetX += _itemWidth;
        
        [_tabViews addObject:itemView];
        
//        __weak typeof(self) weakSelf = self;
//        //从item中选中那个 传tag值过来
//        [itemView addSelectedCallBack:^(NSInteger tag) {
//            if (weakSelf.itemClickBlock) {
//                weakSelf.itemClickBlock(tag);
//            }
//        }];
    }
    _tabScroller.contentSize = CGSizeMake(dataArray.count*_itemWidth, self.height);
}

- (void)handleItemWidthWithItemCount:(NSInteger)count{
    if (_type == YXViewPagerTopViewTypeForNoScroll) {
        _itemWidth = self.width/count;
    }else if(_type == YXViewPagerTopViewTypeForCanScroll){
        if (_itemWidth<1) {//如果在canScroll的模式下面,没有设置itemWidth，默认和noScroll一样处理
            _itemWidth = self.width/count;
        }
    }
}

- (void)tabItemSelected:(NSInteger)index{
    _currentIndex = index;
    for (int i=0; i<_tabViews.count; i++) {
        YXViewPagerTopItemView *tabView = _tabViews[i];
        if (i == index) {
            [tabView settingTabSelect:YES];
        }else{
            [tabView settingTabSelect:NO];
        }
    }
}

- (void)addItemClickBlock : (YXViewPagerTopViewTypeItemClickBlock) block{
    _itemClickBlock = block;
}


- (void)selectedItemTag:(NSInteger)tag{
    NSLog(@"选中按钮下标======%ld",(long)tag);
    [self.delegate didSelegateItemTag:tag];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat itemWidth = _itemWidth;
    CGFloat itemHeight = 60;
    
    CGFloat offsetX = scrollView.contentOffset.x;
//    _maskView.frame = CGRectMake(_currentIndex*itemWidth-offsetX, itemHeight-2, _maskView.width, 1);
    
    _maskView.frame = CGRectMake(_currentIndex*itemWidth-offsetX, 0, _maskView.width, self.height);
}


@end
