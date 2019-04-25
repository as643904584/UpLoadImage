//
//  ZJPostViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/14.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPostViewController.h"
#import "ZJDynamicImageCell.h"
#import "ZJDynamicImageAddCell.h"
#import "ZJAlbumViewController.h"

static const CGFloat collectionViewInsetTop = 130;

@interface ZJPostViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZJPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.topBarView];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:[[UIApplication sharedApplication] statusBarFrame].size.height];
    [self.topBarView autoSetDimension:ALDimensionHeight toSize:44.0f];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(collectionViewInsetTop, 10, 0, 10)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateArray:) name:@"zjgridArray" object:nil];
}

- (void)updateArray:(NSNotification*)notification{
    NSLog(@"%@",notification);
}


#pragma mark -- UI Event

- (void)saveImage:(id)sender{
    NSLog(@"上传接口");
}


- (void)dismissViewController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark -- collectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if(indexPath.row == 0){
        ZJDynamicImageAddCell *addimageCell =  [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ZJDynamicImageAddCell" forIndexPath:indexPath];
        [addimageCell bindmodelwithstr:@"最多添加20张"];
        cell = addimageCell;
    }else
    {
        ZJDynamicImageCell *imageCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ZJDynamicImageCell" forIndexPath:indexPath];
        cell = imageCell;
    }
   
    
   return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSLog(@"添加照片");
        [self addImage];
    }else{
        NSLog(@"展示大图");
    }
}

#pragma mark -- UIEvent
- (void)addImage{
    ZJAlbumViewController *ablumiewController = [[ZJAlbumViewController alloc] init];
    [self presentViewController:ablumiewController animated:YES completion:^{
        
    }];
}


#pragma mark -- UI
- (UIView *)topBarView{
    if(!_topBarView){
        _topBarView = [[UIView alloc] init];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [_topBarView addSubview:lineView];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:44.0f];
        [lineView autoSetDimension:ALDimensionHeight toSize:1.0f];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"zj_back"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(dismissViewController:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:leftButton];
        [leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0f];
        [leftButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [leftButton autoSetDimensionsToSize:CGSizeMake(30, 40)];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        [rightButton setTitle:@"上传" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:rightButton];
        [rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0f];
        [rightButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
    }
    return _topBarView;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.alwaysBounceVertical = true;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_collectionView registerClass:NSClassFromString(@"ZJDynamicImageCell") forCellWithReuseIdentifier:@"ZJDynamicImageCell"];
        [_collectionView registerClass:NSClassFromString(@"ZJDynamicImageAddCell") forCellWithReuseIdentifier:@"ZJDynamicImageAddCell"];
    }
    return _collectionView;
}

@end
