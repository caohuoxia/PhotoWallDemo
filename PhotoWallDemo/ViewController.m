//
//  ViewController.m
//  PhotoWallDemo
//
//  Created by admin on 17/3/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ShowImageVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    //添加相片imageview
    for (int i = 0; i < 8; i++) {
        //image名称
        NSString *imageName = [NSString stringWithFormat:@"17_%d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(10 +(i%3)*130 , (i/3)*210 +10, 120, 200)];
        iv.image = image;
        //打开交互手势才能起效
        iv.userInteractionEnabled = YES;
        [self.scrollView addSubview:iv];
        
        //添加手势
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage:)];
        [iv addGestureRecognizer:ges];
    }
}

- (void)showImage:(UITapGestureRecognizer *)ges{
    UIImageView *iv =  (UIImageView *)ges.view;
    ShowImageVC *vc = [[ShowImageVC alloc]init];
    vc.imge = iv.image;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
