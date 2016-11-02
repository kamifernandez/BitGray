//
//  ViewController.h
//  BitGray
//
//  Created by Christian camilo fernandez on 1/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Indicador

@property(nonatomic,weak)IBOutlet UIButton *btnMenu;
@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;
@property(nonatomic,weak)IBOutlet UILabel * lblTittleHeader;

// NSMutable array

@property(nonatomic,strong)NSMutableArray * data;

// UI/UX

@property(nonatomic,weak)IBOutlet UITextField *name;
@property(nonatomic,weak)IBOutlet UITextField *user;
@property(nonatomic,weak)IBOutlet UITextField *mail;
@property(nonatomic,weak)IBOutlet UITextField *phone;
@property(nonatomic,weak)IBOutlet UITextField *company;

@end

