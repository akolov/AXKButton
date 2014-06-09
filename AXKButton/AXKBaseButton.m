//
//  AXKBaseButton.m
//  AXKButton
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AXKBaseButton.h"

@interface AXKBaseButton ()

@property (nonatomic, strong) NSMutableDictionary *stateStorage;

- (NSMutableDictionary *)storageForControlState:(UIControlState)state;

@end

@implementation AXKBaseButton

+ (NSDictionary *)defaults {
  return nil;
}

#pragma mark - State Storage

- (NSMutableDictionary *)storageForControlState:(UIControlState)state {
  NSMutableDictionary *dictionary = self.stateStorage[@(state)];
  if (!dictionary) {
    dictionary = [NSMutableDictionary dictionary];
    self.stateStorage[@(state)] = dictionary;

    if (state == UIControlStateNormal && [[self class] defaults]) {
      [dictionary addEntriesFromDictionary:[[self class] defaults]];
    }
  }
  return dictionary;
}

- (NSMutableDictionary *)stateStorage {
  if (!_stateStorage) {
    _stateStorage = [NSMutableDictionary dictionary];
  }
  return _stateStorage;
}

- (id)valueForKeyPath:(NSString *)keyPath state:(UIControlState)state {
  NSMutableDictionary *storage = [self storageForControlState:state];
  id value = storage[keyPath];
  return value == [NSNull null] ? nil : value;
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath state:(UIControlState)state {
  NSMutableDictionary *storage = [self storageForControlState:state];
  storage[keyPath] = value;
  [self applyValueAtKeyPathForCurrentState:keyPath];
}

- (void)applyValueAtKeyPathForCurrentState:(NSString *)keyPath {
  if (keyPath) {
    id value = [self valueForKeyPath:keyPath state:self.state];
    if (!value) {
      value = [self valueForKeyPath:keyPath state:UIControlStateNormal];
    }
    [self setValue:value forKeyPath:keyPath];
  }
  else {
    NSDictionary *defaultStateStorage = [self storageForControlState:UIControlStateNormal];
    NSDictionary *currentStateStorage = [self storageForControlState:self.state];
    NSMutableDictionary *mergedStorage = [NSMutableDictionary dictionary];
    [mergedStorage addEntriesFromDictionary:defaultStateStorage];
    [mergedStorage addEntriesFromDictionary:currentStateStorage];
    [mergedStorage enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
      [self setValue:value == [NSNull null] ? nil : value forKeyPath:key];
    }];
  }
}

#pragma mark - UIControl

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  [self applyValueAtKeyPathForCurrentState:nil];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  [self applyValueAtKeyPathForCurrentState:nil];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self applyValueAtKeyPathForCurrentState:nil];
}

#pragma mark - UIResponder methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInset, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
    return [super hitTest:point withEvent:event];
  }

  CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.hitTestEdgeInset);
  if (CGRectContainsPoint(hitFrame, point)) {
    return self;
  }

  return nil;
}

@end
