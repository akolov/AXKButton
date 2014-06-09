//
//  AXKButton.h
//  AXKButton
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

@import UIKit;

//! Project version number for AXKButton.
FOUNDATION_EXPORT double AXKButtonVersionNumber;

//! Project version string for AXKButton.
FOUNDATION_EXPORT const unsigned char AXKButtonVersionString[];

#import "AXKBaseButton.h"
#import "AXKShapeView.h"
#import "AXKTranslucentButton.h"

IB_DESIGNABLE
@interface AXKButton : AXKBaseButton

@property (nonatomic, assign) IBInspectable CGFloat spacing;
@property (nonatomic, assign) IBInspectable UIEdgeInsets contentInset;
@property (nonatomic, assign) IBInspectable NSTextAlignment contentAlignment;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) AXKShapeView *iconView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

- (UIColor *)backgroundColorForState:(UIControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (NSString *)titleForState:(UIControlState)state;
- (void)setTitle:(NSString *)title forState:(UIControlState)state;

- (NSAttributedString *)attributedTitleForState:(UIControlState)state;
- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state;

- (UIColor *)titleColorForState:(UIControlState)state;
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

- (UIColor *)iconFillColorForState:(UIControlState)state;
- (void)setIconFillColor:(UIColor *)color forState:(UIControlState)state;

- (UIColor *)iconStrokeColorForState:(UIControlState)state;
- (void)setIconStrokeColor:(UIColor *)color forState:(UIControlState)state;

@end
