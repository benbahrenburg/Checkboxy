/*
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "M13Checkbox.h"
#import "TiUtils.h"
@interface BencodingCheckboxCheckbox : TiUIView {
    M13Checkbox * checkboxView;
}

-(void) toggle:(id)unused;
- (IBAction)checkChanged:(id)sender;
@end
