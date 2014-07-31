//
//  ViewController.m
//  DragCellPrototype
//
//  Created by Ashwarya Singh on 7/30/14.
//  Copyright (c) 2014 A1. All rights reserved.
//

#import "ViewController.h"
#import "CustomGroupCell.h"

static NSString* DequeueReusableCell = @"DequeueReusableCell";

@interface ViewController ()
@property (nonatomic, strong) I3DragBetweenHelper* helper;
@property (nonatomic, strong) NSMutableArray* leftData;
@property (nonatomic, strong) NSIndexPath *selectedGroup;

@property (nonatomic, strong) NSMutableArray* collectionData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* The table data sources and delegates */
    
    NSArray* leftData = @[
                          @"Left 1",
                          @"Left 2",
                          @"Left 3",
                          @"Left 4",
                          @"Left 5",
                          @"Left 6",
                          @"Left 7",
                          @"Left 8",
                          @"Left 9",
                          ];

    
    self.leftData = [NSMutableArray arrayWithArray:leftData];
    self.collectionData=[[NSMutableArray alloc]initWithObjects:[[NSMutableArray alloc]initWithObjects:@"Group 11",
                                                                                                      @"Group 12",
                                                                                                      @"Group 13",
                                                                                                      @"Group 14",
                                                                                                      @"Group 15", nil],
                                                               [[NSMutableArray alloc]initWithObjects:@"Group 21",
                                                                                                      @"Group 22",
                                                                                                      @"Group 23",
                                                                                                      @"Group 24",
                                                                                                      @"Group 25", nil],
                                                               [[NSMutableArray alloc]initWithObjects:@"Group 31",
                                                                                                      @"Group 32",
                                                                                                      @"Group 33",
                                                                                                      @"Group 34",
                                                                                                      @"Group 35", nil],nil];
    
    [self.groupSection registerClass:[CustomGroupCell class] forCellWithReuseIdentifier:@"Cell"];
    
    /* Configure the helper */
    
    self.helper = [[I3DragBetweenHelper alloc] initWithSuperview:self.view // The UIView we're draggin around in
                                                         srcView:self.memberTableView // The Src
                                                         dstView:self.groupSection]; // The Dst
    
    self.helper.delegate = self;
    self.helper.isDstRearrangeable = NO;
    self.helper.isSrcRearrangeable = YES;
    self.helper.hideSrcDraggingCell = NO;
    self.helper.hideDstDraggingCell = NO;
    self.helper.doesDstRecieveSrc=YES;
    self.helper.doesSrcRecieveDst=NO;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    NSInteger row = [indexPath row];
    cell.textLabel.text = [self.leftData objectAtIndex:row];
    return cell;
}


//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
 //   return 2;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellData=[self.collectionData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Drag n Drop rearrange delegate methods

/** This is implemented in accordance with isDstRearrangeable */

-(void) droppedOnDstAtIndexPath:(NSIndexPath*) to fromSrcIndexPath:(NSIndexPath*) from
{
    NSInteger fromRow = [from row];
    NSInteger toRow = [to row];
    
    [[self.collectionData objectAtIndex:toRow] addObject:[self.leftData objectAtIndex:fromRow]];
    CustomGroupCell *cgc = (CustomGroupCell *)[self.groupSection cellForItemAtIndexPath:to];
    [cgc.groupTableView reloadData];
}

-(BOOL) isCellAtIndexPathDraggable:(NSIndexPath*) index inContainer:(UIView*) container{
    if ([container isKindOfClass:[UICollectionView class]]) {
        return NO;
    }
    else
        return YES;

}

-(void)draggingAtIndexPath:(NSIndexPath *)indexpath
{
    if (![self.selectedGroup isEqual:indexpath])
    {
        for (CustomGroupCell *cell in self.groupSection.subviews) {
            [cell.layer setBorderColor:[UIColor clearColor].CGColor];
            [cell.layer setBorderWidth:0.0f];
        }
        CustomGroupCell *cgc = (CustomGroupCell *)[self.groupSection cellForItemAtIndexPath:indexpath];
        [cgc.layer setBorderColor:[UIColor greenColor].CGColor];
        [cgc.layer setBorderWidth:3.0f];
        self.selectedGroup=indexpath;
    }
}
@end
