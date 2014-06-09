//
//  AXKBaseButton.h
//  AXKButton
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

@import UIKit;

@interface AXKBaseButton : UIControl

@property (nonatomic, assign) IBInspectable UIEdgeInsets hitTestEdgeInset;

- (id)valueForKeyPath:(NSString *)keyPath state:(UIControlState)state;
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath state:(UIControlState)state;
- (void)applyValueAtKeyPathForCurrentState:(NSString *)keyPath;

+ (NSDictionary *)defaults;

@end
