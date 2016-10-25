//
//  ADCell1.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/3/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ADCell1 : UITableViewCell
@property(nonatomic, weak) IBOutlet UIImageView *ivLeft;
@property(nonatomic, weak) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbProp1;
@property (weak, nonatomic) IBOutlet UILabel *lbProp2;
@property (weak, nonatomic) IBOutlet UILabel *lbProp3;
@property (weak, nonatomic) IBOutlet UILabel *lbProp4;
@property (weak, nonatomic) IBOutlet UILabel *lbProp5;
@property (weak, nonatomic) IBOutlet UILabel *lbProp6;
@property (weak, nonatomic) IBOutlet UIImageView *ivRight;

@end
