//
//  AXKButton.m
//  AXKButton
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AXKButton.h"

@interface AXKButton ()

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL didSetupContentConstraints;

@property (nonatomic, strong) NSLayoutConstraint *topInsetConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomInsetConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leftInsetConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightInsetConstraint;
@property (nonatomic, strong) NSLayoutConstraint *spacingConstraint;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) AXKShapeView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AXKButton

+ (NSDictionary *)defaults {
  return @{@"backgroundColor"      : [NSNull null],
           @"iconView.fillColor"   : [NSNull null],
           @"iconView.strokeColor" : [NSNull null]};
}

- (void)updateConstraints {
  if (!self.didSetupConstraints) {
    self.topInsetConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0];
    [self addConstraint:self.topInsetConstraint];

    self.bottomInsetConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationLessThanOrEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0];
    [self addConstraint:self.bottomInsetConstraint];

    self.leftInsetConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0];
    [self addConstraint:self.leftInsetConstraint];

    self.rightInsetConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.0
                                                              constant:0];
    [self addConstraint:self.rightInsetConstraint];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];

    self.didSetupConstraints = YES;
  }

  if (!self.didSetupContentConstraints) {
    [self.contentView removeConstraints:self.contentView.constraints];

    if (_iconView) {
      [self.contentView addConstraint:
       [NSLayoutConstraint constraintWithItem:self.iconView
                                    attribute:NSLayoutAttributeLeading
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self.contentView
                                    attribute:NSLayoutAttributeLeading
                                   multiplier:1
                                     constant:0]];

      [self.contentView addConstraints:
       [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[_iconView]-(>=0)-|" options:0 metrics:nil
                                                 views:NSDictionaryOfVariableBindings(_iconView)]];
    }

    if (_titleLabel) {
      [self.contentView addConstraint:
       [NSLayoutConstraint constraintWithItem:self.titleLabel
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self.contentView
                                    attribute:NSLayoutAttributeTrailing
                                   multiplier:1
                                     constant:0]];

      [self.contentView addConstraints:
       [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[_titleLabel]-(>=0)-|" options:0 metrics:nil
                                                 views:NSDictionaryOfVariableBindings(_titleLabel)]];
    }

    if (_iconView && _titleLabel) {
      self.spacingConstraint = [NSLayoutConstraint constraintWithItem:self.iconView
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.titleLabel
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1
                                                             constant:-self.spacing];

      [self.contentView addConstraint:self.spacingConstraint];

      [self.contentView addConstraint:
       [NSLayoutConstraint constraintWithItem:self.iconView
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self.titleLabel
                                    attribute:NSLayoutAttributeCenterY
                                   multiplier:1
                                     constant:0]];
    }
    else if (_iconView) {
      [self.contentView addConstraint:
       [NSLayoutConstraint constraintWithItem:self.iconView
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self.contentView
                                    attribute:NSLayoutAttributeTrailing
                                   multiplier:1
                                     constant:0]];
    }
    else if (_titleLabel) {
      [self.contentView addConstraint:
       [NSLayoutConstraint constraintWithItem:self.titleLabel
                                    attribute:NSLayoutAttributeLeading
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self.contentView
                                    attribute:NSLayoutAttributeLeading
                                   multiplier:1
                                     constant:0]];
    }

    self.didSetupContentConstraints = YES;
  }

  self.topInsetConstraint.constant = self.contentInset.top;
  self.bottomInsetConstraint.constant = -self.contentInset.bottom;
  self.leftInsetConstraint.constant = self.contentInset.left;
  self.rightInsetConstraint.constant = -self.contentInset.right;

  [super updateConstraints];
}

#pragma mark - Subviews

- (UIView *)contentView {
  if (!_contentView) {
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.opaque = NO;
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentView.userInteractionEnabled = NO;
    [self addSubview:_contentView];

    self.didSetupContentConstraints = NO;
  }
  return _contentView;
}

- (UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.opaque = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];

    self.didSetupContentConstraints = NO;
  }
  return _titleLabel;
}

- (AXKShapeView *)iconView {
  if (!_iconView) {
    _iconView = [[AXKShapeView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.opaque = NO;
    _iconView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_iconView];

    self.didSetupContentConstraints = NO;
  }
  return _iconView;
}

#pragma mark - Properties

- (void)setDidSetupConstraints:(BOOL)didSetupConstraints {
  if (_didSetupConstraints == didSetupConstraints) {
    return;
  }

  _didSetupConstraints = didSetupConstraints;

  if (didSetupConstraints == NO) {
    [self setNeedsUpdateConstraints];
  }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
  if (UIEdgeInsetsEqualToEdgeInsets(_contentInset, contentInset)) {
    return;
  }

  _contentInset = contentInset;

  [self setNeedsUpdateConstraints];
}

- (void)setSpacing:(CGFloat)spacing {
  if (_spacing == spacing) {
    return;
  }

  _spacing = spacing;

  self.spacingConstraint.constant = -spacing;
}

#pragma mark - Background Color

- (UIColor *)backgroundColorForState:(UIControlState)state {
  return [self valueForKeyPath:@"backgroundColor" state:state];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
  [self setValue:color forKeyPath:@"backgroundColor" state:state];
}

#pragma mark - Title Text

- (NSAttributedString *)attributedTitleForState:(UIControlState)state {
  return [self valueForKeyPath:@"titleLabel.attributedText" state:state];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
  [self setValue:title forKeyPath:@"titleLabel.attributedText" state:state];
}

- (NSString *)titleForState:(UIControlState)state {
  return [self valueForKeyPath:@"titleLabel.text" state:state];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
  [self setValue:title forKeyPath:@"titleLabel.text" state:state];
}

#pragma mark - Title Color

- (UIColor *)titleColorForState:(UIControlState)state {
  return [self valueForKeyPath:@"titleLabel.textColor" state:state];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
  [self setValue:color forKeyPath:@"titleLabel.textColor" state:state];
}

#pragma mark - Icon Color

- (UIColor *)iconFillColorForState:(UIControlState)state {
  return [self valueForKeyPath:@"iconView.fillColor" state:state];
}

- (void)setIconFillColor:(UIColor *)color forState:(UIControlState)state {
  [self setValue:color forKeyPath:@"iconView.fillColor" state:state];
}

- (UIColor *)iconStrokeColorForState:(UIControlState)state {
  return [self valueForKeyPath:@"iconView.strokeColor" state:state];
}

- (void)setIconStrokeColor:(UIColor *)color forState:(UIControlState)state {
  [self setValue:color forKeyPath:@"iconView.strokeColor" state:state];
}

@end
