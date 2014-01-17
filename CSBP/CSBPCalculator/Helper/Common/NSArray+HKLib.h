//
//  NSArray+HKLib.h
//  MovPlex
//
//  Created by Hendrik Kusuma on 10/25/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(HKLib)
- (BOOL)hasObject;
- (id)firstObject;
- (id)randomObject;

- (NSArray *)map:(NSString *)key;

- (id)selectObject:(BOOL (^)(id obj))block;
- (NSArray *)selectObjects:(BOOL (^)(id obj))block;
@end
