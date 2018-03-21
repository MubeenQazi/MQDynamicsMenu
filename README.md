# MQDynamicsMenu

UIKit Dynamic effect on menu views. Just have to pass menu view to MQMenuComponent and thats it.

https://developer.apple.com/documentation/uikit/uidynamicitembehavior?language=objc

Check demo project for reference.

# How to use:

MQMenuComponent *menuComponent = [[MQMenuComponent alloc]initWithMenuViewController:self menuView:menuView direction:leftToRight];

self.menuComponent.acceleration = 20;

self.menuComponent.elasticity = 0.3;


![Screen Shot](SS1.png?raw=true "")
