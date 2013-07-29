//
//  InfoViewController.m
//  Clock
//
//  Created by Suncry on 13-7-1.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "InfoViewController.h"
#import "DayViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self addGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView             // Default is 1 if not implemented
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
{
    return @"更多";
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row == %d",indexPath.row);
}



//创建cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //config the cell
    if (0 == indexPath.row)
    {
        cell.textLabel.text = @"关于";

    }
    if (1 == indexPath.row)
    {
        cell.textLabel.text = @"反馈";
        
    }
    if (2 == indexPath.row)
    {
        cell.textLabel.text = @"重置出生年月";
        
    }
    
    return cell;
}

//添加手势
- (void)addGesture
{
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];

    

}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    
      if(recognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        
        NSLog(@"swipe right");
        //执行程序
        DayViewController *dayViewController = [[DayViewController alloc]init];
        [self presentViewController:dayViewController animated:YES completion:nil];
        
    }
}

@end
