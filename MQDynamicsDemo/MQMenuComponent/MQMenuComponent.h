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

@protocol MQMenuComponentProtocol <NSObject>

- (void)didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface MQMenuComponent : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIColor *menuBackgroundColor;
@property (nonatomic, strong) NSMutableDictionary *tableSettings;
@property (nonatomic) CGFloat elasticity;
@property (nonatomic) CGFloat optionCellHeight;
@property (nonatomic) CGFloat acceleration;
@property (nonatomic) BOOL isScrollable;
@property (nonatomic) BOOL showSeparator;
@property (nonatomic, strong) NSString *title;
@property (nonatomic,weak) id <MQMenuComponentProtocol> delegate;

- (id)initMenuWithFrame:(CGRect)frame targetView:(UIView *)targetView direction:(MenuDirectionOptions)direction options:(NSArray *)options optionImages:(NSArray *)optionImages;

- (void)showMenu;





@end
