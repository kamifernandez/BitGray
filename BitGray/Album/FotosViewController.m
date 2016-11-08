//
//  FotosViewController.m
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import "FotosViewController.h"
#import "ManageInternetRequest.h"
#import "FotosCollectionViewCell.h"

@interface FotosViewController ()

@end

@implementation FotosViewController

- (void)viewDidLoad {
    [self language];
    [self requestServer];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)language{
    [self.lblTittleHeader setText:NSLocalizedString(@"Photos", nil)];
    [self.lblLoading setText:NSLocalizedString(@"Loading", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

-(IBAction)backPhotos:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RequestServer Álbum

-(void)requestServer{
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    if ([[_defaults objectForKey:@"connectioninternet"] isEqualToString:@"YES"]) {
        [self mostrarCargando];
        NSOperationQueue * queue1 = [[NSOperationQueue alloc] init];
        [queue1 setMaxConcurrentOperationCount:1];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(envioServerRequestFotos) object:nil];
        [queue1 addOperation:operation];
    }else{
        NSMutableDictionary *msgDict=[[NSMutableDictionary alloc] init];
        [msgDict setValue:@"Atención" forKey:@"Title"];
        [msgDict setValue:@"No tiene conexión a internet." forKey:@"Message"];
        [msgDict setValue:@"Aceptar" forKey:@"Cancel"];
        [msgDict setValue:@"" forKey:@"Aceptar"];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:msgDict
                            waitUntilDone:YES];
    }
}

-(void)envioServerRequestFotos{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setObject:self.idAlbum forKey:@"idAlbum"];
    _data = [ManageInternetRequest organizer:@"fotos" data:data];
    NSLog(@"%@",[[_data objectAtIndex:0] objectForKey:@"title"]);
    [self performSelectorOnMainThread:@selector(ocultarCargandoFotos) withObject:nil waitUntilDone:YES];
}

-(void)ocultarCargandoFotos{
    if ([_data count] > 0) {
        [self.collection reloadData];
    }else{
        NSMutableDictionary *msgDict=[[NSMutableDictionary alloc] init];
        [msgDict setValue:@"Atención" forKey:@"Title"];
        [msgDict setValue:@"No hay álbum para mostrar" forKey:@"Message"];
        [msgDict setValue:@"Aceptar" forKey:@"Cancel"];
        [msgDict setValue:@"" forKey:@"Aceptar"];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:msgDict
                            waitUntilDone:YES];
    }
    [self mostrarCargando];
}

#pragma mark - CollectionView Delegates


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FotosCollectionViewCell";
    
    FotosCollectionViewCell *cell = (FotosCollectionViewCell *)[self.collection dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString * urlEnvio = [[self.data objectAtIndex:indexPath.row] objectForKey: @"thumbnailUrl"];
    if ([urlEnvio isEqualToString:@""]) {
        [cell.indicator stopAnimating];
        [cell.imgPhoto setFrame:CGRectMake(cell.imgPhoto.frame.origin.x, cell.imgPhoto.frame.origin.y - 15, cell.imgPhoto.frame.size.width, cell.imgPhoto.frame.size.height)];
    }else{
        NSURL *imageURL = [NSURL URLWithString:urlEnvio];
        NSString *key = [[[self.data objectAtIndex:indexPath.row] objectForKey: @"logo"] MD5Hash];
        NSData *data = [FTWCache objectForKey:key];
        if (data) {
            [cell.indicator stopAnimating];
            UIImage *image = [UIImage imageWithData:data];
            cell.imgPhoto.image = image;
        } else {
            //imagen.image = [UIImage imageNamed:@"img_def"];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData *data = [NSData dataWithContentsOfURL:imageURL];
                [FTWCache setObject:data forKey:key];
                UIImage *image = [UIImage imageWithData:data];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [cell.indicator stopAnimating];
                    cell.imgPhoto.image = image;
                });
            });
        }
    }

    cell.imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imgPhoto.layer setMasksToBounds:YES];
    
    cell.lblTittlePhoto.text = [[self.data objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - showAlert metodo

-(void)showAlert:(NSMutableDictionary *)msgDict
{
    if ([[msgDict objectForKey:@"Aceptar"] length]>0) {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:[msgDict objectForKey:@"Title"]
                            message:[msgDict objectForKey:@"Message"]
                            delegate:self
                            cancelButtonTitle:[msgDict objectForKey:@"Cancel"]
                            otherButtonTitles:[msgDict objectForKey:@"Aceptar"],nil];
        [alert setTag:[[msgDict objectForKey:@"Tag"] intValue]];
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:[msgDict objectForKey:@"Title"]
                            message:[msgDict objectForKey:@"Message"]
                            delegate:self
                            cancelButtonTitle:[msgDict objectForKey:@"Cancel"]
                            otherButtonTitles:nil];
        [alert setTag:[[msgDict objectForKey:@"Tag"] intValue]];
        [alert show];
    }
}

#pragma mark - Metodos Vista Cargando

-(void)mostrarCargando{
    @autoreleasepool {
        if (_vistaWait.hidden == TRUE) {
            _vistaWait.hidden = FALSE;
            CALayer * l = [_vistaWait layer];
            [l setMasksToBounds:YES];
            [l setCornerRadius:10.0];
            // You can even add a border
            [l setBorderWidth:1.5];
            [l setBorderColor:[[UIColor whiteColor] CGColor]];
            
            [_indicador startAnimating];
        }else{
            _vistaWait.hidden = TRUE;
            [_indicador stopAnimating];
        }
    }
}

@end
