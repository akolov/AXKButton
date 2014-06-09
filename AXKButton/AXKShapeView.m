//
//  STShapeView.m
//  Stylight
//
//  Created by Alexander Kolov on 6/25/13.
//  Copyright (c) 2013 Stylight. All rights reserved.
//

#import "AXKShapeView.h"

@implementation AXKShapeView

+ (Class)layerClass {
  return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.userInteractionEnabled = NO;
  }
  return self;
}

- (CAShapeLayer *)shapeLayer {
  return (CAShapeLayer *)self.layer;
}

- (void)setPath:(UIBezierPath *)path {
  if (_path != path) {
    _path = path;
    self.shapeLayer.path = _path.CGPath;
    self.shapeLayer.frame = _path.bounds;
    [self invalidateIntrinsicContentSize];
  }
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

#pragma mark - Public methods

- (CGSize)sizeThatFits:(CGSize)size {
  CGFloat const w = CGRectGetWidth(self.bounds);
  CGFloat const h = CGRectGetHeight(self.bounds);
  CGFloat const a1 = size.width / size.height;
  CGFloat const a2 = w / h;

  if (a1 > a2) {
    return CGSizeMake(size.width, size.height * 1 / a2);
  }
  else {
    return CGSizeMake(size.width * a2, size.height);
  }
}

- (void)setFillColor:(UIColor *)fillColor {
  if ([_fillColor isEqual:fillColor]) {
    return;
  }

  _fillColor = fillColor;
  self.shapeLayer.fillColor = fillColor.CGColor;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
  if ([_strokeColor isEqual:strokeColor]) {
    return;
  }

  _strokeColor = strokeColor;
  self.shapeLayer.strokeColor = strokeColor.CGColor;
}

@end
