//
//  DetailViewController.h
//  ex_MasterDetailAppTemplate
//
//  Created by yoshiyuki oshige on 2013/09/06.
//  Copyright (c) 2013年 yoshiyuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
