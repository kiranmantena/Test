//
//  NSArray+HKLib.m
//  MovPlex
//
//  Created by Hendrik Kusuma on 10/25/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//

#import "NSArray+HKLib.h"

@implementation NSArray(HKLib)
- (BOOL)hasObject {
	return (self.count > 0);
}

- (id)firstObject {
	if ([self hasObject]) {	
		return [self objectAtIndex:0];
	} else {
		return nil;
	}
}

- (id)randomObject {
	if ([self hasObject]) {
		return [self objectAtIndex: (random() % [self count])];
	} else {
		return nil;
	}
}

- (id)selectObject:(BOOL (^)(id obj))block {
    for (id object in self) {
        if (block(object) == YES) {
            return object;
        }
    }
    
    return nil;
}

- (id)selectObjects:(BOOL (^)(id obj))block {
    NSMutableArray *array = [NSMutableArray array]; 
    for (id object in self) {
        if (block(object) == YES) {
            [array addObject:object];
        }
    }
    
    return array;
}


- (NSArray *)map:(NSString *)key {
	NSMutableArray *array = [NSMutableArray array];
	[self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		if ([object isKindOfClass:[NSDictionary class]]) {
			id keyValue = [object objectForKey:key];
			if (keyValue != nil) {
				[array addObject:keyValue];
			}
		}
	}];
	return array;
}
@end
