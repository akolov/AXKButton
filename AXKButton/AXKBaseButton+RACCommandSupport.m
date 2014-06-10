//
//  AXKBaseButton+RACCommandSupport.m
//  AXKButton
//
//  Created by Alexander Kolov on 10/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

@import ObjectiveC.runtime;

#import "AXKBaseButton+RACCommandSupport.h"

#import <ReactiveCocoa/RACEXTKeyPathCoding.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AXKBaseButton (RACCommandSupport_Private)

@property (nonatomic, strong) RACDisposable *enabledDisposable;

@end

@implementation AXKBaseButton (RACCommandSupport)

- (RACDisposable *)enabledDisposable {
  return objc_getAssociatedObject(self, @selector(enabledDisposable));
}

- (void)setEnabledDisposable:(RACDisposable *)enabledDisposable {
  objc_setAssociatedObject(self, @selector(enabledDisposable), enabledDisposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACCommand *)rac_command {
  return objc_getAssociatedObject(self, @selector(rac_command));
}

- (void)setRac_command:(RACCommand *)command {
  objc_setAssociatedObject(self, @selector(rac_command), command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

  // Check for stored signal in order to remove it and add a new one
  [self.enabledDisposable dispose];

  if (command == nil) return;

  self.enabledDisposable = [command.enabled setKeyPath:@keypath(self.enabled) onObject:self];

  [self rac_hijackActionAndTargetIfNeeded];
}

- (void)rac_hijackActionAndTargetIfNeeded {
  SEL hijackSelector = @selector(rac_commandPerformAction:);

  for (NSString *selector in [self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside]) {
    if (hijackSelector == NSSelectorFromString(selector)) {
      return;
    }
  }

  [self addTarget:self action:hijackSelector forControlEvents:UIControlEventTouchUpInside];
}

- (void)rac_commandPerformAction:(id)sender {
  [self.rac_command execute:sender];
}

@end
