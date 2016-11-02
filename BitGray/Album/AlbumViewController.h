//
//  AlbumViewController.h
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController

@property(nonatomic,weak)IBOutlet UITableView * table;
@property(nonatomic,weak)IBOutlet UITableViewCell * cellAlbumTableView;
@property(nonatomic,weak)IBOutlet UILabel * lblTittleHeader;

// NSmutable array

@property(nonatomic,strong)NSMutableArray * data;

// Table Cell

@property(nonatomic,weak)IBOutlet UILabel * lblTittle;

@property(nonatomic,weak)IBOutlet UIImageView * imgIcon;

// Indicador

@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;

@end
