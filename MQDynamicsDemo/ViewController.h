//
//  ViewController.h
//  DynamicsDemo
//
//  Created by Mubeen Raza Qazi on 15/11/2017.
//  Copyright © 2017 Mubeen Raza Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQMenuComponent.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MQMenuComponent *menuComponent;

- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer;

@end

