//
//  MenuComponent.h
//  DynamicsDemo
//
//  Created by Mubeen Raza Qazi on 15/11/2017.
//  Copyright © 2017 Mubeen Raza Qazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum MQMenuDirectionTypes{
    leftToRight,
    rightToLeft,
} MenuDirectionOptions;

@interface MQMenuComponent : NSObject

@property (nonatomic) CGFloat elasticity;
@property (nonatomic) CGFloat acceleration;

- (id)initWithMenuViewController:(UIViewController*)targetViewController menuView:(UIView*)menuView direction:(MenuDirectionOptions)direction;

- (void)showMenu;





@end
