//
//  AXKBaseButton+RACCommandSupport.h
//  AXKButton
//
//  Created by Alexander Kolov on 10/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AXKButton.h"

@class RACCommand;

@interface AXKBaseButton (RACCommandSupport)

/// Sets the button's command. When the button is clicked, the command is
/// executed with the sender of the event. The button's enabledness is bound
/// to the command's `canExecute`.
@property (nonatomic, strong) RACCommand *rac_command;

@end
