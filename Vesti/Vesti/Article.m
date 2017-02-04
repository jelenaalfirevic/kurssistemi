//
//  Article.m
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "Article.h"
@implementation Article

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.title = [dictionary objectForKey:@"title"];
        self.desc = dictionary [@"description"];
        self.imageURL = dictionary [@"imageUrl"];
        self.region = dictionary [@"regio0n"];
        self.portal = dictionary [@"portal"];
        self.url = dictionary [@"url"];

    }
                
    return self;
            
}
@end
