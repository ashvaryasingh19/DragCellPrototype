//
//  CustomGroupCell.h
//  DragCellPrototype
//
//  Created by Ashwarya Singh on 7/30/14.
//  Copyright (c) 2014 A1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomGroupCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *groupTableView;
@property(strong,nonatomic) NSMutableArray *cellData;
@property(strong,nonatomic) NSString *groupName;
@end