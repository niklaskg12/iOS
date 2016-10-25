//
//  ADAddressCell.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *addressTitle;
@property (weak, nonatomic) IBOutlet UILabel *addressTown;
@property (weak, nonatomic) IBOutlet UILabel *addressRepair;
@property (weak, nonatomic) IBOutlet UILabel *addressTel;

@end
