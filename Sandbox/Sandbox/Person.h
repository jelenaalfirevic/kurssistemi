//
//  Person.h
//  Sandbox
//
//  Created by Jelena Alfirevic on 12/3/16.
//  Copyright © 2016 Jelena Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Person : NSObject
@property (nonatomic) NSInteger jmbg;
@property (strong, nonatomic) NSString *ime;
@property (strong, nonatomic) NSString *prezime;
@property (nonatomic) NSInteger godine;
@property (strong, nonatomic) NSDate *datumRodjenja;
@property (nonatomic) CGFloat racun;

- (void)predstaviSe;
- (void)kaziStanjeRacuna;
- (void)kupiArtikal:(CGFloat)cena;
@end
