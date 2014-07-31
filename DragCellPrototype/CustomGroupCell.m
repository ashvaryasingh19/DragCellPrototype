//
//  CustomGroupCell.m
//  DragCellPrototype
//
//  Created by Ashwarya Singh on 7/30/14.
//  Copyright (c) 2014 A1. All rights reserved.
//

#import "CustomGroupCell.h"

@implementation CustomGroupCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.cellData = [[NSMutableArray alloc] init];

        self.groupTableView=[[UITableView alloc]initWithFrame:CGRectMake(100,50,120,320)];
        self.groupTableView.delegate=self;
        self.groupTableView.dataSource=self;
        [self setBackgroundColor:[UIColor grayColor]];
        [self addSubview:self.groupTableView];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [self.cellData objectAtIndex:indexPath.row];
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
