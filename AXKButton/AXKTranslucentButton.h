//
//  AXKTranslucentButton.h
//  AXKButton
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AXKBaseButton.h"

IB_DESIGNABLE
@interface AXKTranslucentButton : AXKBaseButton

@property (nonatomic, strong) UIFont *font;

- (UIColor *)backgroundColorForState:(UIControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (NSAttributedString *)attributedTitleForState:(UIControlState)state;
- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state;

- (NSString *)titleForState:(UIControlState)state;
- (void)setTitle:(NSString *)title forState:(UIControlState)state;

@end
