/*
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingCheckboxCheckboxProxy.h"

@implementation BencodingCheckboxCheckboxProxy


-(void)toggle:(id)unused
{
    [[self view] performSelectorOnMainThread:@selector(toggle:)
                                  withObject:unused waitUntilDone:NO];
}
@end
