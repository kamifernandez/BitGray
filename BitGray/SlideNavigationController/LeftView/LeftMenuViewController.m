//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AlbumViewController.h"
#import "PostViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    if (([[UIScreen mainScreen] bounds].size.height == 480)) {
        [self.tableView setScrollEnabled:YES];
    }
    
    self.identifierStory = @"ViewController";
    
	self.tableView.separatorColor = [UIColor whiteColor];
    self.descripcionCelda = [[NSMutableArray alloc] init];
    for (int i = 0; i<3; i++) {
        NSMutableDictionary * dataTemp = [NSMutableDictionary new];
        if (i == 0) {
            [dataTemp setObject:@"ic_perm_identity_white.png" forKeyedSubscript:@"icono"];
            [dataTemp setObject:NSLocalizedString(@"User", nil) forKeyedSubscript:@"tittle"];
        }else if (i == 1){
            [dataTemp setObject:@"ic_wallpaper_white.png" forKeyedSubscript:@"icono"];
            [dataTemp setObject:NSLocalizedString(@"Album/Photos", nil) forKeyedSubscript:@"tittle"];
        }else if (i == 2){
            [dataTemp setObject:@"ic_speaker_notes_white.png" forKeyedSubscript:@"icono"];
            [dataTemp setObject:NSLocalizedString(@"Post", nil) forKeyedSubscript:@"tittle"];
        }
        [_descripcionCelda addObject:dataTemp];
    }
}

#pragma mark - UITableView Delegate & Datasrouce

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_descripcionCelda count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *CellIdentifier = @"CellLeftMenu";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"CellLeftMenu" owner:self options:nil];
        cell = _celdaTabla;
        self.celdaTabla=nil;
    }
    
    UIImageView *imgIcono = (UIImageView *)[cell viewWithTag:1];
    [imgIcono setImage:[UIImage imageNamed:[[_descripcionCelda objectAtIndex:indexPath.row] objectForKey:@"icono"]]];
    
    UILabel *lblTittle = (UILabel *)[cell viewWithTag:2];
    [lblTittle setText:[[_descripcionCelda objectAtIndex:indexPath.row] objectForKey:@"tittle"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
	UIViewController *vc ;
	
	switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ViewController"];
            self.identifierStory = @"ViewController";
            break;
            
        case 1:{
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"AlbumViewController"];
            self.identifierStory = @"AlbumViewController";
            break;
        }case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"PostViewController"];
            self.identifierStory = @"PostViewController";
            break;
    }
	
	[[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
