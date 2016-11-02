//
//  FotosViewController.h
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTWCache.h"
#import "NSString+MD5.h"

@interface FotosViewController : UIViewController

@property(nonatomic,weak)IBOutlet UICollectionView * collection;
@property(nonatomic,weak)IBOutlet UILabel * lblTittleHeader;

@property(nonatomic,strong)NSString * idAlbum;

// NSmutable array

@property(nonatomic,strong)NSMutableArray * data;

// Indicador

@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;

@end
