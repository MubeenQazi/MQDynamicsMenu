# MQDynamicMenu

Easy to user generic menu view has been created using UIKit Dynamics with effects gravity, elasticity and acceleration.
https://developer.apple.com/documentation/uikit/uidynamicitembehavior?language=objc
Check demo project for reference.
How to use:

MQMenuComponent *menuComponent = [[MQMenuComponent alloc] initMenuWithFrame:desiredMenuFrame targetView:self.view direction:leftToRight options:menuItems optionImages:menuItemImages];
menuComponent.delegate = self;
menuComponent.menuBackgroundColor = [UIColor colorWithRed:0.95 green:0.54 blue:0.54 alpha:1.0];
menuComponent.acceleration = 20;
menuComponent.optionCellHeight = 60;
menuComponent.title = @"Dynamics Demo";
menuComponent.elasticity = 0.1;

# Protocol
MQMenuComponentProtocol


# Callback:
- (void) didSelectRowAtIndexPath:(NSIndexPath*)indexPath;



![ScreenShot](https://raw.github.com/MubeenQazi/MQDynamicMenu/master/SS1.PNG)
