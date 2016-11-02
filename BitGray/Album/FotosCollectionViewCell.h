//
//  FotosCollectionViewCell.h
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FotosCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UIImageView * imgPhoto;

@property (nonatomic, retain) IBOutlet UILabel * lblTittlePhoto;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * indicator;

@end
