//
//  Person.m
//  Sandbox
//
//  Created by Jelena Alfirevic on 12/3/16.
//  Copyright © 2016 Jelena Alfirevic. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark - Public API

- (void)predstaviSe {
    NSLog(@"Ja sam %@ %@", self.ime, self.prezime);
}

- (void)kaziStanjeRacuna {
    NSLog(@"Stanje racuna: %f", self.racun);
}

- (void)kupiArtikal:(CGFloat)cena {
    if (self.racun > cena) {
        self.racun = self.racun - cena;
    }
}

@end
