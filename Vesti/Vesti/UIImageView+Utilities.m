//
//  UIImageView+Utilities.m
//  Vesti
//
//  Created by Djuro Alfirevic on 2/4/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "UIImageView+Utilities.h"

@implementation UIImageView (Utilities)

#pragma mark - Public API

- (void)loadImageFromURL:(NSString *)url {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ImageDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
            
        });
    });
}

@end
