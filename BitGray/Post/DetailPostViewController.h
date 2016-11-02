//
//  DetailPostViewController.h
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPostViewController : UIViewController

@property(nonatomic,weak)IBOutlet UILabel * lblTittle;
@property(nonatomic,strong)NSString * idPost;

@property(nonatomic,strong)NSMutableDictionary * dataRecibe;

// headerPostView

@property(nonatomic,weak)IBOutlet UIView *headerPostView;
@property(nonatomic,weak)IBOutlet UILabel *lblTittlePost;
@property(nonatomic,weak)IBOutlet UILabel *lblBody;
@property(nonatomic,weak)IBOutlet UILabel *lblnumberComments;

// NSMutable array

@property(nonatomic,strong)NSMutableArray * data;

//TableView

@property(nonatomic,weak)IBOutlet UITableView * table;
@property(nonatomic,weak)IBOutlet UITableViewCell * cellPostTableView;

// Table Cell

@property(nonatomic,weak)IBOutlet UILabel * lblName;

@property(nonatomic,weak)IBOutlet UILabel * lblDescription;

@property(nonatomic,weak)IBOutlet UIImageView * imgIcon;

// Indicador

@property(nonatomic,weak)IBOutlet UIView *vistaWait;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indicador;

@end
