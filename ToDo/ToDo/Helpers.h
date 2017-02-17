//
//  Helpers.h
//  ToDo
//
//  Created by Djuro Alfirevic on 2/15/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject
+ (BOOL)isMorning;
+ (NSString *)valueFrom:(NSDate *)date withFormat:(NSString *)format;
@end
