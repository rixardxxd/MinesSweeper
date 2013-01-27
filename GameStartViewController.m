//
//  GameStartViewController.m
//  MinesSweeper
//
//  Created by Xiaodi Xing on 1/25/13.
//  Copyright (c) 2013 Xiaodi Xing. All rights reserved.
//

#import "GameStartViewController.h"
#import "GameViewController.h"

@interface GameStartViewController ()

@end

@implementation GameStartViewController
@synthesize LevelControll;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gameStart:(id)sender {
    GameViewController *gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    gameVC.level = self.LevelControll.selectedSegmentIndex;
    [self.navigationController pushViewController:gameVC animated:YES];
    
    
}
@end
