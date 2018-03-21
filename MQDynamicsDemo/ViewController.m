//
//  ViewController.m
//  DynamicsDemo
//
//  Created by Mubeen Raza Qazi on 15/11/2017.
//  Copyright © 2017 Mubeen Raza Qazi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    __weak IBOutlet UIView *menuView;
    NSArray *menuItems;
    NSArray *menuItemImages;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSwipeGesture];
    
    menuItems = @[@"Home", @"Notification", @"E-mail", @"Settings", @"About"];
    menuItemImages = @[@"home", @"home", @"home", @"home", @"home"];
    
    self.menuComponent = [[MQMenuComponent alloc]initWithMenuViewController:self menuView:menuView direction:leftToRight];
    
    self.menuComponent.acceleration = 20;
    
    self.menuComponent.elasticity = 0.3;
    
}


- (void)addSwipeGesture{
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:gesture];
}


-(void)didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"%@",indexPath);
}


- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer{
    [self.menuComponent showMenu];
}


#pragma mark - Table View Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuItems count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
    }
    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
    
    [cell.imageView setImage:[UIImage imageNamed:[menuItemImages objectAtIndex:indexPath.row]]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imageView setTintColor:[UIColor whiteColor]];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}





@end
