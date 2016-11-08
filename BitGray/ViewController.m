//
//  ViewController.m
//  BitGray
//
//  Created by Christian camilo fernandez on 1/11/16.
//  Copyright © 2016 Christian Camilo Fernandez. All rights reserved.
//

#import "ViewController.h"
#import "SlideNavigationController.h"
#import "ManageInternetRequest.h"

@interface ViewController (){
    NSInteger number;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    [self language];
    if (![_defaults objectForKey:@"id"]) {
        [self performSelector:@selector(requestServerUser) withObject:nil afterDelay:0.5];
    }else{
        [self userDataSave];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)language{
    [self.lblTittleHeader setText:NSLocalizedString(@"User", nil)];
    [self.lblLoading setText:NSLocalizedString(@"Loading", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

-(IBAction)openMenu:(id)sender{
    [self.view endEditing:YES];
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}


#pragma mark - RequestServerUser

-(void)requestServerUser{
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    if ([[_defaults objectForKey:@"connectioninternet"] isEqualToString:@"YES"]) {
        [self mostrarCargando];
        NSOperationQueue * queue1 = [[NSOperationQueue alloc] init];
        [queue1 setMaxConcurrentOperationCount:1];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(envioServerUser) object:nil];
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

-(void)envioServerUser{
    _data = [ManageInternetRequest organizer:@"usuarios" data:nil];
    NSLog(@"%@",[[_data objectAtIndex:0] objectForKey:@"id"]);
    [self performSelectorOnMainThread:@selector(ocultarCargandoUser) withObject:nil waitUntilDone:YES];
}

-(void)ocultarCargandoUser{
    if ([_data count] > 0) {
        number = [self randomNumber];
        [self userData];
        [self.btnMenu setEnabled:TRUE];
    }else{
    }
    [self mostrarCargando];
}

-(NSInteger)randomNumber{
    int dataCount = (int)[self.data count];
    NSInteger randomNumber = arc4random() % dataCount;
    return randomNumber;
}

#pragma mark - Own Methods

-(void)userData{
    [self.name setText:[[self.data objectAtIndex:number] objectForKey:@"name"]];
    [self.user setText:[[self.data objectAtIndex:number] objectForKey:@"username"]];
    [self.mail setText:[[self.data objectAtIndex:number] objectForKey:@"email"]];
    [self.phone setText:[[self.data objectAtIndex:number] objectForKey:@"phone"]];
    NSMutableDictionary * companyData = [[self.data objectAtIndex:number] objectForKey:@"company"];
    [self.company setText:[companyData objectForKey:@"name"]];
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    [_defaults setObject:[[self.data objectAtIndex:number] objectForKey:@"id"] forKey:@"id"];
    [_defaults setObject:[[self.data objectAtIndex:number] objectForKey:@"name"] forKey:@"name"];
    [_defaults setObject:[[self.data objectAtIndex:number] objectForKey:@"username"] forKey:@"username"];
    [_defaults setObject:[[self.data objectAtIndex:number] objectForKey:@"email"] forKey:@"email"];
    [_defaults setObject:[[self.data objectAtIndex:number] objectForKey:@"phone"] forKey:@"phone"];
    [_defaults setObject:[companyData objectForKey:@"name"] forKey:@"company"];
}

-(void)userDataSave{
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    [self.name setText:[_defaults objectForKey:@"name"]];
    [self.user setText:[_defaults objectForKey:@"username"]];
    [self.mail setText:[_defaults objectForKey:@"email"]];
    [self.phone setText:[_defaults objectForKey:@"phone"]];
    [self.company setText:[_defaults objectForKey:@"company"]];
    [self.btnMenu setEnabled:TRUE];
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
