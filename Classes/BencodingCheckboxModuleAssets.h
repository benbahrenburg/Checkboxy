/*
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

@interface BencodingCheckboxModuleAssets : NSObject
{
}
- (NSData*) moduleAsset;
- (NSData*) resolveModuleAsset:(NSString*)path;

@end
