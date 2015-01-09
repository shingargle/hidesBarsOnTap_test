//
//  DetailViewController.m
//  ex_MasterDetailAppTemplate
//
//  Created by yoshiyuki oshige on 2013/09/06.
//  Copyright (c) 2013年 yoshiyuki. All rights reserved.
//
//  Modyfy by ogata on 2015/01/09

#import "DetailViewController.h"

@interface DetailViewController () <UIGestureRecognizerDelegate>
- (void)configureView;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property BOOL shouldBeHidingStatusBar;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.hidesBarsOnTap = true;
    // タップを検知して何かしたいとき
    UITapGestureRecognizer * tapGesture = self.navigationController.barHideOnTapGestureRecognizer;
    [tapGesture addTarget:self action:@selector(handleTapGesture:)];
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // この画面から離れるときは、Targetをはずして、hidesBarsOnTap を NO にする。
    [self.navigationController.barHideOnTapGestureRecognizer removeTarget:self action:@selector(handleTapGesture:)];
    self.navigationController.hidesBarsOnTap = NO;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    int num = self.count.text.intValue;
    num++;
    if (num>9) {
        num = 0;
    }
    self.count.text = [NSString stringWithFormat:@"%d", num];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    // StatusBarをnavigationBarと連動させる
    return self.navigationController.navigationBarHidden;
}

@end
