//
//  Bookmark.m
//  Browser
//
//  Created by Djuro Alfirevic on 3/10/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "Bookmark.h"

@implementation Bookmark

#pragma mark - Designated Initializer

- (instancetype)initWithTitle:(NSString *)title andURL:(NSString *)url {
    if (self = [super init]) {
        self.title = title;
        self.url = url;
    }
    
    return self;
}
@end
