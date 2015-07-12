//
//  ViewController.m
//  MHPageScrollAutoLayoutSample
//
//  Created by 小屋敷 圭史 on 2015/07/12.
//  Copyright © 2015年 小屋敷 圭史. All rights reserved.
//

#import "ViewController.h"
#import "Child1ViewController.h"
#import "Child2ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) Child1ViewController *child1ViewController;
@property (nonatomic, strong) Child2ViewController *child2ViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self setupScrollView];
    
}

- (void)viewDidLayoutSubviews
{
    CGRect scrollViewRect = self.scrollView.frame;
//    self.scrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 2, scrollViewRect.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupScrollView
{
    self.child1ViewController = [[Child1ViewController alloc] initWithNibName:nil bundle:nil];
    self.child2ViewController = [[Child2ViewController alloc] initWithNibName:nil bundle:nil];
    
    [self addChildViewController:self.child1ViewController];
    [self addChildViewController:self.child2ViewController];
    
    UIView *subView1 = self.child1ViewController.view;
    UIView *subView2 = self.child2ViewController.view;
    
    subView1.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    subView2.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:subView1];
    [self.scrollView addSubview:subView2];
    
    
    // 制約をつける
    subView1.translatesAutoresizingMaskIntoConstraints = NO;
    subView2.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSNumber *padding = @0;
    UIView *scrollView = self.scrollView;
    NSDictionary *metricsDictionary = NSDictionaryOfVariableBindings(padding);
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(subView1, subView2, scrollView);
    
    [self.scrollView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[subView1(==scrollView)]-padding-[subView2(==scrollView)]-padding-|"
                                             options:0
                                             metrics:metricsDictionary
                                               views:viewsDictionary]];
    [self.scrollView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[subView1(==scrollView)]-padding-|"
                                             options:0
                                             metrics:metricsDictionary
                                               views:viewsDictionary]];
    [self.scrollView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[subView2(==scrollView)]-padding-|"
                                             options:0
                                             metrics:metricsDictionary
                                               views:viewsDictionary]];
}

@end
