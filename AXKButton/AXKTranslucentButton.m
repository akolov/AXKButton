//
//  SAXKTranslucentButton.m
//  AXKButton
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AXKTranslucentButton.h"

@interface AXKTranslucentButton ()

@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, strong) NSString *text;

@end

@implementation AXKTranslucentButton

void constructor(AXKTranslucentButton *self) {
  self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

+ (NSDictionary *)defaults {
  return @{@"backgroundColor": [NSNull null]};
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    constructor(self);
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  constructor(self);
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetBlendMode(context, kCGBlendModeCopy);
  CGContextSetTextDrawingMode(context, kCGTextFill);

  NSStringDrawingContext *stringContext = [[NSStringDrawingContext alloc] init];
  stringContext.minimumScaleFactor = 0.8f;

  CGFloat const w = CGRectGetWidth(rect);
  CGFloat const h = CGRectGetHeight(rect);

  if (self.attributedText) {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect const boundingRect = [self.attributedText boundingRectWithSize:rect.size options:options context:stringContext];
    CGFloat const bw = CGRectGetWidth(boundingRect);
    CGFloat const bh = CGRectGetHeight(boundingRect);

    CGRect frame = rect;
    frame.origin.x = (w - bw) / 2;
    frame.origin.y = (h - bh) / 2;
    frame.size.width = bw;
    frame.size.height = bh;

    [self.attributedText drawWithRect:frame options:options context:stringContext];
  }
  else if (self.text) {
    NSDictionary *const attributes = @{NSFontAttributeName: self.font, NSForegroundColorAttributeName: [UIColor clearColor]};
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect boundingRect = [self.text boundingRectWithSize:rect.size options:options attributes:attributes context:stringContext];
    CGFloat const bw = CGRectGetWidth(boundingRect);
    CGFloat const bh = CGRectGetHeight(boundingRect);

    CGRect frame = rect;
    frame.origin.x = (w - bw) / 2;
    frame.origin.y = (h - bh) / 2;
    frame.size.width = bw;
    frame.size.height = bh;

    [self.text drawWithRect:frame options:options attributes:attributes context:stringContext];
  }
}

#pragma mark - Properties

- (void)setFont:(UIFont *)font {
  if ([_font isEqual:font]) {
    return;
  }

  _font = font;

  [self setNeedsDisplay];
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
  return [self valueForKeyPath:@"attributedText" state:state];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
  [self setValue:title forKeyPath:@"attributedText" state:state];
}

- (NSString *)titleForState:(UIControlState)state {
  return [self valueForKeyPath:@"text" state:state];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
  [self setValue:title forKeyPath:@"text" state:state];
}

#pragma mark - AXKBaseButton

- (void)applyValueAtKeyPathForCurrentState:(NSString *)keyPath {
  [super applyValueAtKeyPathForCurrentState:keyPath];
  [self setNeedsDisplay];
}

@end
