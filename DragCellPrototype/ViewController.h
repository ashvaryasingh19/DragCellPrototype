//
//  ViewController.h
//  DragCellPrototype
//
//  Created by Ashwarya Singh on 7/30/14.
//  Copyright (c) 2014 A1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "I3DragBetweenHelper.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,I3DragBetweenDelegate>

@property(nonatomic,weak) IBOutlet UICollectionView *groupSection;
@property(nonatomic,weak) IBOutlet UITableView *memberTableView;



@end
