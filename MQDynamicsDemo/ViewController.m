//
//  ViewController.m
//  DynamicsDemo
//
//  Created by Mubeen Raza Qazi on 15/11/2017.
//  Copyright © 2017 Mubeen Raza Qazi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSwipeGesture];
    
    CGRect desiredMenuFrame = CGRectMake(0.0, 0.0, self.view.center.x, self.view.frame.size.height);
    
    NSArray *menuItems = @[@"Home", @"Notification", @"E-mail", @"Settings", @"About"];
    
    NSArray *menuItemImages = @[@"home", @"home", @"home", @"home", @"home"];
    
    self.menuComponent = [[MQMenuComponent alloc] initMenuWithFrame:desiredMenuFrame
                                                       targetView:self.view
                                                        direction:leftToRight
                                                          options:menuItems
                                                     optionImages:menuItemImages];
    self.menuComponent.delegate = self;
    self.menuComponent.menuBackgroundColor = [UIColor colorWithRed:0.95 green:0.54 blue:0.54 alpha:1.0];
    self.menuComponent.acceleration = 20;
    self.menuComponent.optionCellHeight = 60;
    self.menuComponent.title = @"Dynamics Menu Demo";
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




@end
