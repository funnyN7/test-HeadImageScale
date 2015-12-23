//
//  ViewController.m
//  HeadImageScale-demo
//
//  Created by yq on 15/12/23.
//  Copyright © 2015年 yq. All rights reserved.
//

#import "ViewController.h"
#import "testCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak,nonatomic)  UIImageView * headImageView;

@end


#define k
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIImageView * tableViewHeadImageView = ({
    
        tableViewHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 212)];
        [tableViewHeadImageView setImage:[UIImage imageNamed:@"1.jpg"]];
        tableViewHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
        tableViewHeadImageView;
    
    });
    
    self.tableView.tableHeaderView = tableViewHeadImageView;
    
    self.headImageView = tableViewHeadImageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGAffineTransform transform =   self.headImageView.transform;
    NSLog(@"%f",self.headImageView.frame.size.height);
    NSLog(@"yOffset===%f",yOffset);
    if (yOffset < 0) {
        CGFloat  headerScaleFactor = -(yOffset)/self.headImageView.bounds.size.height;
        CGFloat  headerSizeVariation = - (yOffset)- ((self.headImageView.bounds.size.height*(1.0+headerScaleFactor))-self.headImageView.frame.size.height)/2;
        NSLog(@"212121%f",headerSizeVariation);
//        transform = CATransform3DTranslate(transform, 0,headerSizeVariation, 0);
//        transform = CATransform3DScale(transform, 1.0+headerScaleFactor, 1.0+headerScaleFactor, 0);
        //transform =  CGAffineTransformMakeTranslation(0, headerSizeVariation);
        transform =  CGAffineTransformMakeScale(1.0+headerScaleFactor,1.0+headerScaleFactor);
        transform =  CGAffineTransformTranslate (transform,0,headerSizeVariation);
        self.headImageView.transform = transform;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    testCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"testCell" owner:self options:nil]firstObject];
    }
    cell.contentLabel.text = @"123";
    return cell;
    
}

@end
