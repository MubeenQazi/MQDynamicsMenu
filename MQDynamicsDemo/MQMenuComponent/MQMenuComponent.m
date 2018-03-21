//
//  MenuComponent.m
//  DynamicsDemo
//
//  Created by Mubeen Raza Qazi on 15/11/2017.
//  Copyright © 2017 Mubeen Raza Qazi. All rights reserved.
//

#import "MQMenuComponent.h"

@interface MQMenuComponent()

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UITableView *optionsTableView;
@property (nonatomic, strong) NSArray *menuOptions;
@property (nonatomic, strong) NSArray *menuOptionImages;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic) MenuDirectionOptions menuDirection;
@property (nonatomic) CGRect menuFrame;
@property (nonatomic) CGRect menuInitialFrame;
@property (nonatomic) BOOL isMenuShown;

- (void)setupMenuView;
- (void)setupBackgroundView;
- (void)setupOptionsTableView;
- (void)setInitialTableViewSettings;
- (void)setupSwipeGestureRecognizer;
- (void)toggleMenu;
- (void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture;

@end


@implementation MQMenuComponent

#pragma mark - Table View Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuOptions count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.optionCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
    }
    
    [cell setSelectionStyle:[[self.tableSettings objectForKey:@"selectionStyle"] intValue]];
    cell.textLabel.text = [self.menuOptions objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[self.tableSettings objectForKey:@"font"]];
    [cell.textLabel setTextAlignment:[[self.tableSettings objectForKey:@"textAlignment"] intValue]];
    [cell.textLabel setTextColor:[self.tableSettings objectForKey:@"textColor"]];
    
    
    if (self.menuOptionImages != nil) {
        [cell.imageView setImage:[UIImage imageNamed:[self.menuOptionImages objectAtIndex:indexPath.row]]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.imageView setTintColor:[UIColor whiteColor]];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]){
        [self.delegate didSelectRowAtIndexPath:indexPath];
    }
    [self toggleMenu];
    self.isMenuShown = NO;
}

#pragma mark - Setup

- (id)initMenuWithFrame:(CGRect)frame targetView:(UIView *)targetView direction:(MenuDirectionOptions)direction options:(NSArray *)options optionImages:(NSArray *)optionImages {
    if (self = [super init]) {
        self.menuFrame = frame;
        self.targetView = targetView;
        self.menuDirection = direction;
        self.menuOptions = options;
        self.menuOptionImages = optionImages;
        
        [self setupBackgroundView];
        
        [self setupMenuView];
        
        [self setupSwipeGestureRecognizer];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.targetView];
        
        self.optionCellHeight = 50.0;
        
        self.elasticity = 0.3;
        
        self.acceleration = 15.0;
        
        self.isMenuShown = NO;
        
    }
    
    return self;
}


- (id)initWithMenuViewController:(UIViewController*)targetViewController menuView:(UIView*)menuView direction:(MenuDirectionOptions)direction{
    if (self = [super init]) {
        
        self.targetView = targetViewController.view;
        
        self.menuFrame = menuView.frame;
        
        self.menuDirection = direction;
        
        //[self setupBackgroundView];
        
        self.menuView = menuView;
        
        //[self setupMenuView];
        
        [self setupSwipeGestureRecognizer];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.targetView];
        
        self.optionCellHeight = 50.0;
        
        self.elasticity = 0.3;
        
        self.acceleration = 15.0;
        
        self.isMenuShown = NO;
        
    }
    
    return self;
}

- (void)setupMenuView {
    
    if (self.menuDirection == leftToRight) {
        self.menuInitialFrame = CGRectMake(-self.menuFrame.size.width,
                                           self.menuFrame.origin.y,
                                           self.menuFrame.size.width,
                                           self.menuFrame.size.height);
    }
    else{
        self.menuInitialFrame = CGRectMake(self.targetView.frame.size.width,
                                           self.menuFrame.origin.y,
                                           self.menuFrame.size.width,
                                           self.menuFrame.size.height);
    }
    
    [self.menuView setFrame: self.menuInitialFrame];
    
//    [self.menuView setBackgroundColor:[UIColor greenColor]];
//    [self.targetView addSubview:self.menuView];
}


- (void)setupBackgroundView {
    self.backgroundView = [[UIView alloc]initWithFrame:self.targetView.frame];
    [self.backgroundView setBackgroundColor:[UIColor darkGrayColor]];
    [self.backgroundView setAlpha:0.0];
    [self.targetView addSubview:self.backgroundView];
}

- (void)setupSwipeGestureRecognizer {
    UISwipeGestureRecognizer *hideMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuWithGesture:)];
    if (self.menuDirection == leftToRight) {
        hideMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    else{
        hideMenuGesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    [self.menuView addGestureRecognizer:hideMenuGesture];
}

- (void)showMenu {
    if (!self.isMenuShown) {
        [self toggleMenu];
        self.isMenuShown = YES;
    }
}

- (void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture {
    [self toggleMenu];
    self.isMenuShown = NO;
}


- (void)toggleMenu{
    [self.animator removeAllBehaviors];
    
    CGFloat gravityDirectionX;
    CGPoint collisionPointFrom, collisionPointTo;
    
    CGFloat pushMagnitude = self.acceleration;
    
    if (!self.isMenuShown) {
        
        if (self.menuDirection == leftToRight) {
            gravityDirectionX = 1.0;
            collisionPointFrom = CGPointMake(self.menuFrame.size.width, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(self.menuFrame.size.width, self.menuFrame.size.height);
        }
        else{
            gravityDirectionX = -1.0;
            collisionPointFrom = CGPointMake(self.targetView.frame.size.width - self.menuFrame.size.width, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(self.targetView.frame.size.width - self.menuFrame.size.width, self.menuFrame.size.height);
            pushMagnitude = (-1) * pushMagnitude;
        }
        
        [self.backgroundView setAlpha:0.5];
    }
    else{
        
        if (self.menuDirection == leftToRight) {
            gravityDirectionX = -1.0;
            collisionPointFrom = CGPointMake(-self.menuFrame.size.width, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(-self.menuFrame.size.width, self.menuFrame.size.height);
            
            pushMagnitude = (-1) * pushMagnitude;
        }
        else{
            gravityDirectionX = 1.0;
            collisionPointFrom = CGPointMake(self.targetView.frame.size.width + self.menuFrame.size.width, self.menuFrame.origin.y);
            collisionPointTo = CGPointMake(self.targetView.frame.size.width + self.menuFrame.size.width, self.menuFrame.size.height);
        }
        [self.backgroundView setAlpha:0.0];
    }
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.menuView]];
    [gravityBehavior setGravityDirection:CGVectorMake(gravityDirectionX, 0.0)];
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.menuView]];
    [collisionBehavior addBoundaryWithIdentifier:@"collisionBoundary"
                                       fromPoint:collisionPointFrom
                                         toPoint:collisionPointTo];
    [self.animator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.menuView]];
    [itemBehavior setElasticity:self.elasticity];
    [self.animator addBehavior:itemBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.menuView] mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setMagnitude:pushMagnitude];
    [self.animator addBehavior:pushBehavior];
    
}

@end
