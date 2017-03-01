//
//  DataManager.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/25/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

#pragma mark - Properties

- (void)setUserLocation:(CLLocation *)userLocation {
    _userLocation = userLocation;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            NSLog(@"CLGeocoder error: %@", error.localizedDescription);
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark =[placemarks firstObject];
            
            self.userLocality = placemark.locality;
            
            NSLog(@"ISOCountryCode: %@", placemark.ISOcountryCode);
            NSLog(@"Country: %@", placemark.country);
            NSLog(@"Postal code: %@", placemark.postalCode);
            NSLog(@"Administrative area: %@", placemark.administrativeArea);
            NSLog(@"Locality: %@", placemark.locality);
            NSLog(@"Sub locality: %@", placemark.subLocality);

        }
        
    }];
}

- (void)setUserLocality:(NSString *)userLocality {
    _userLocality = userLocality;
    
    // Via delegate
    if (self.delegate) {
        [self.delegate dataManagerDidUpdateLocality];
    }
    
    // Via notification
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCALITY_UPDATED_NOTIFICATION object:nil];
}

#pragma mark - Designted Initializer

+ (instancetype)sharedManager {
    static DataManager *shared;
    
    @synchronized (self) {
        if (shared == nil) {
            shared = [[DataManager alloc] init];
        }
    }
    
    return shared;
}


@end
