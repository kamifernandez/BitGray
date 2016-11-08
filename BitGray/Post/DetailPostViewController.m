//
//  DetailPostViewController.m
//  BitGray
//
//  Created by Christian camilo fernandez on 2/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import "DetailPostViewController.h"
#import "ManageInternetRequest.h"

@interface DetailPostViewController ()

@end

@implementation DetailPostViewController

- (void)viewDidLoad {
    [self configurerView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurerView{
    [self.lblLoading setText:NSLocalizedString(@"Loading", nil)];
    [self.lblTittle setText:NSLocalizedString(@"Post Detail", nil)];
    [[NSBundle mainBundle] loadNibNamed:@"HeaderPostView" owner:self options:nil];
    self.table.tableHeaderView = self.headerPostView;
    [self.lblTittlePost setText:[self.dataRecibe objectForKey:@"title"]];
    [self.lblBody setText:[self.dataRecibe objectForKey:@"body"]];
    NSString * string = [self.dataRecibe objectForKey:@"body"];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    int heigthView = [self widthReturn:trimmedString]-120;
    [self.lblBody setFrame:CGRectMake(self.lblBody.frame.origin.x, self.lblTittlePost.frame.origin.y + self.lblTittlePost.frame.size.height, self.lblBody.frame.size.width, heigthView)];
    [self.lblnumberComments setFrame:CGRectMake(self.lblnumberComments.frame.origin.x, self.lblBody.frame.origin.y + self.lblBody.frame.size.height + 10, self.lblnumberComments.frame.size.width, self.lblnumberComments.frame.size.height)];
    [self.headerPostView setFrame:CGRectMake(self.headerPostView.frame.origin.x, self.headerPostView.frame.origin.y, self.headerPostView.frame.size.width,self.lblnumberComments.frame.origin.y + self.lblnumberComments.frame.size.height)];
    [self requestServer];
}

#pragma mark - Own Methods

-(CGFloat)widthReturn:(NSString *)text{
    CGFloat width;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0)
    {
        width = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0 ]].width;
    }
    else
    {
        width = ceil([text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0]}].width);
    }
    
    return width;
}
#pragma mark - RequestServer Comments

-(void)requestServer{
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    if ([[_defaults objectForKey:@"connectioninternet"] isEqualToString:@"YES"]) {
        [self mostrarCargando];
        NSOperationQueue * queue1 = [[NSOperationQueue alloc] init];
        [queue1 setMaxConcurrentOperationCount:1];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(envioServerRequestComments) object:nil];
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

-(void)envioServerRequestComments{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setObject:self.idPost forKey:@"postId"];
    _data = [ManageInternetRequest organizer:@"comment" data:data];
    NSLog(@"%@",[[_data objectAtIndex:0] objectForKey:@"email"]);
    [self performSelectorOnMainThread:@selector(ocultarCargandoCommnets) withObject:nil waitUntilDone:YES];
}

-(void)ocultarCargandoCommnets{
    if ([_data count] > 0) {
        [self.table reloadData];
        [self.lblnumberComments setText:[NSString stringWithFormat:@"%@: %i",NSLocalizedString(@"Comment", nil),(int)[_data count]]];
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

#pragma mark - IBAction

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate & Datasrouce

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *CellIdentifier = @"CellDetailPostViewController";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"CellDetailPostViewController" owner:self options:nil];
        cell = _cellPostTableView;
        self.cellPostTableView = nil;
    }
    
    [self.lblName setText:[[_data objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [self.lblDescription setText:[[_data objectAtIndex:indexPath.row] objectForKey:@"body"]];
    NSString * string = [[_data objectAtIndex:indexPath.row] objectForKey:@"body"];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    int heigthView = [self widthReturn:trimmedString] - 160;
    [self.lblDescription setFrame:CGRectMake(self.lblDescription.frame.origin.x, self.lblDescription.frame.origin.y, self.lblDescription.frame.size.width,heigthView)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat returnHeigth = [self widthReturn:[[_data objectAtIndex:indexPath.row] objectForKey:@"body"]];
    int heigthRow = (self.lblName.frame.origin.y + self.lblName.frame.size.height) + (self.lblDescription.frame.origin.y + returnHeigth + 15);
    return heigthRow - 160;
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
