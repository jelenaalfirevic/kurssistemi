//
//  ViewController.m
//  Sandbox
//
//  Created by Jelena Alfirevic on 12/2/16.
//  Copyright © 2016 Jelena Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Tipovi promenljivih
    float racun = 650.5;
    float predmet = 50.5;
    const int cena = 100;
    NSInteger x = 1000000000000;
    CGFloat y = 144.3;
    
    // IF
    if (racun > predmet) {
        racun = racun - predmet;
    } else {
        NSLog(@"Nemas dovoljno novca!");
    }
    
    BOOL imamKafu = YES;
    BOOL imamRinglu = NO;
    
    if (imamKafu && imamRinglu) {
        NSLog(@"Skuvacu kafu");
    } else {
        NSLog(@"Necu skuvati kafu");
    }
    
    BOOL imamMleko = YES;
    BOOL imamHleb = NO;
    
    if (imamMleko || imamHleb) {
        NSLog(@"Pojescu nesto");
    } else {
        NSLog(@"Necu pojesti nesto");
    }
    
    // IF..ELSE IF
    if (imamRinglu) {
        
    } else if (imamHleb) {
        
    } else if (imamMleko) {
        
    } else {
        NSLog(@"nemam nista");
    }
    
    int broj = 4;
    broj++; // broj = broj + 1
    broj += 3;
    
    // FOR
    NSArray *niz = @[@"Biljana", @"Branka", @"Jelena", @"Milan"];
    
    // 1.
    for (int i = 0; i < niz.count; i++) {
        if (i == 1) {
            break;
        }
        NSString *clan = niz[i];
        //NSLog(@"%@", clan);
    }
    
    // 2.
    for (NSString *clan in niz) {
        //[self predstaviSe:clan];
        [self predstaviSe:clan saRacunom:racun];
    }
    
    // SWITCH
    int switchBroj = 1;
    switch (switchBroj) {
        case 1:
            NSLog(@"uradi nesto");
            break;
        case 2:
            NSLog(@"uradi nesto drugo");
            break;
        case 3:
            NSLog(@"sve si uradio");
            break;
        default:
            NSLog(@"ne znam sta je ovo");
            break;
    }
    
    // WHILE
    int i = 0;
    while (i < niz.count) {
        NSLog(@"WHILE test");
        i++;
    }
    
    // DO...WHILE
    do {
        NSLog(@"DO...WHILE test");
    } while (4 > 5);
    
    // Metode
    [self reciZdravo];
    
    // Problem?
    NSInteger racunKlijenta1 = 100;
    NSInteger predmet1 = 20;
    racunKlijenta1 = [self odradiToStoTrebaDaOdradisZaRacun:racunKlijenta1
                                              zaOvajPredmet:predmet1];
    
    NSInteger racunKlijenta2 = 200;
    NSInteger predmet2 = 43;
    racunKlijenta2 = [self odradiToStoTrebaDaOdradisZaRacun:racunKlijenta2
                                              zaOvajPredmet:predmet2];
    
    NSInteger racunKlijenta3 = 200;
    NSInteger predmet3 = 43;
    racunKlijenta3 = [self odradiToStoTrebaDaOdradisZaRacun:racunKlijenta3
                                              zaOvajPredmet:predmet3];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    Person *branka = [[Person alloc] init];
    
    // Ime
    NSString *ime = @"Branka";
    
    branka.ime = ime.uppercaseString;
    branka.ime = [ime uppercaseString];
    
    branka.prezime = @"Marinko";
    branka.godine = 25;
    branka.racun = 1000000;
    [branka predstaviSe];
    [branka kupiArtikal:500];
    [branka kaziStanjeRacuna];
    [branka kupiArtikal:300];
    [branka kaziStanjeRacuna];
    branka = nil;
    
    Person *biljana = [[Person alloc] init];
    branka = biljana;
    
    biljana.ime = @"Biljana";
    branka.prezime = @"Marinko";
    
    NSArray *niz = @[branka, biljana];
    for (Person *osoba in niz) {
        [osoba predstaviSe];
    }
    
    NSString *test = @"Branka";
    NSLog(@"BROJ KARAKTERA: %d", test.length);
    
    // Create button
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 100, 200, 200);
    [button setTitle:@"Jelena" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

#pragma mark - Private API

- (NSInteger)odradiToStoTrebaDaOdradisZaRacun:(NSInteger)racun
                                zaOvajPredmet:(NSInteger)predmet {
    NSInteger privremeniRacun = racun - predmet - 14;
    
    return privremeniRacun;
}

- (void)reciZdravo {
    NSLog(@"ZDRAVO!!!!");
}

- (void)predstaviSe:(NSString *)ime {
    NSLog(@"Dobar dan, ja se zovem %@", ime);
}

- (void)predstaviSe:(NSString *)ime saRacunom:(NSInteger)racun {
    NSLog(@"Dobar dan, ja se zovem %@, i na mom racunu se nalazi %d", ime, racun);
}

@end
