//
//  STShapeView.h
//  Stylight
//
//  Created by Alexander Kolov on 6/25/13.
//  Copyright (c) 2013 Stylight. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE
@interface AXKShapeView : UIView

@property (nonatomic, readonly) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;

@end
