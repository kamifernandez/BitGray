//
//  PostViewController.h
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController

@property(nonatomic,weak)IBOutlet UILabel *lblTittlePost;

//

@property(nonatomic,weak)IBOutlet UITableView * table;
@property(nonatomic,weak)IBOutlet UITableViewCell * cellPostTableView;

// Table Cell

@property(nonatomic,weak)IBOutlet UILabel * lblTittle;

@property(nonatomic,weak)IBOutlet UIImageView * imgIcon;

// NSMutable array

@property(nonatomic,strong)NSMutableArray * data;

// Indicador

@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;

@end
