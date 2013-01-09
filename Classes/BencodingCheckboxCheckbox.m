/*
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingCheckboxCheckbox.h"

@implementation BencodingCheckboxCheckbox

-(void)dealloc
{
    [checkboxView removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
	RELEASE_TO_NIL(checkboxView);
	[super dealloc];
}
-(void)layoutSubviews
{
    [checkboxView setFrame:[self bounds]];
    [super layoutSubviews];
}
-(M13Checkbox*)checkboxView
{
	if (checkboxView==nil)
	{
         checkboxView = [[M13Checkbox alloc] init];
        [checkboxView addTarget:self action:@selector(checkChanged:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:checkboxView];
	}
	return checkboxView;
}

-(BOOL)hasTouchableListener
{
	// since this guy only works with touch events, we always want them
	// just always return YES no matter what listeners we have registered
	return YES;
}

-(void)setValue_:(id)value
{
	// need to check if we're in a reproxy when this is set
	// so we don't artifically trigger a change event or
	// animate the change -- this happens on the tableview
	// reproxy as we scroll
	BOOL reproxying = [self.proxy inReproxy];
	BOOL newValue = [TiUtils boolValue:value];

    if ([self checkboxView].checked == newValue) {
        return;
    }

    [[self checkboxView] setChecked:newValue];
    
	// Don't rely on switchChanged: - isOn can report erroneous values immediately after the value is changed!
	// This only seems to happen in 4.2+ - could be an Apple bug.
	if ((reproxying == NO) && configurationSet && [self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:value forKey:@"value"]];
	}
}

-(void)setEnabled_:(id)value
{
	[[self checkboxView] setEnabled:[TiUtils boolValue:value]];
}

-(void) setTitle_:(id)text
{
    [[self checkboxView] setTitle:[TiUtils stringValue:text]];
}
-(void) toggle:(id)unused
{
    self.checkboxView.toggleState;
}
-(void) setFlat_:(id)value
{
    BOOL newValue = [TiUtils boolValue:value];
    M13Checkbox * ourSwitch = [self checkboxView];
    if ([ourSwitch flat] == newValue) {
            return;
    }else{
        ourSwitch.flat = newValue;
    }
}
-(void)setStrokeWidth_:(id)value
{
    CGFloat newValue = [TiUtils floatValue:value def:0];
    self.checkboxView.strokeWidth = newValue;
}
-(void)setStrokeColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
    self.checkboxView.strokeColor = clr;
}
-(void)setCheckColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
    self.checkboxView.checkColor = clr;
}
-(void)setUncheckedColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
    self.checkboxView.uncheckedColor = clr;
}

- (IBAction)checkChanged:(id)sender
{
	NSNumber * newValue = [NSNumber numberWithBool:[(UISwitch *)sender isOn]];
	[self.proxy replaceValue:newValue forKey:@"value" notification:NO];
    
	//No need to setValue, because it's already been set.
	if ([self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
	}
}

-(CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
	return [checkboxView sizeThatFits:CGSizeZero].height;
}

USE_PROXY_FOR_VERIFY_AUTORESIZING
@end
