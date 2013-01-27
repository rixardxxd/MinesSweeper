//
//  GameViewController.m
//  MinesSweeper
//
//  Created by Xiaodi Xing on 1/25/13.
//  Copyright (c) 2013 Xiaodi Xing. All rights reserved.
//

#import "GameViewController.h"
#import "Cell.h"
//#define MaxCellNumber 16
//#define Mine 30
@interface GameViewController (){
    int MaxCellNumber;
    int Mine;
    int timeSec;
    int timeMin;
    NSTimer *timer;
}
@property(nonatomic,strong) NSMutableArray *Cells;
@property(nonatomic,strong) NSMutableArray *Mines;
@property(nonatomic,strong) UILabel *timeLabel;
@end


@implementation GameViewController
@synthesize Cells;
@synthesize level;
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
    switch (level) {
        case 0:
            MaxCellNumber = 3;
            Mine = 1;
            break;
        case 1:
            MaxCellNumber = 10;
            Mine = 20;
            break;
        case 2:
            MaxCellNumber = 16;
            Mine = 30;
            break;
        default:
            break;
    }
    int width = self.view.frame.size.width;
//    int height = self.view.frame.size.height;
    self.Cells = [[NSMutableArray alloc] initWithCapacity:MaxCellNumber*MaxCellNumber];
    self.Mines = [[NSMutableArray alloc] initWithCapacity:Mine];
    for (int i = 0; i<MaxCellNumber; i++) {
        for (int j = 0;j<MaxCellNumber; j++)
        {
            Cell *cell = [[Cell alloc] initWithFrame:CGRectMake(i*width/MaxCellNumber, j*width/MaxCellNumber, width/MaxCellNumber, width/MaxCellNumber)];
            [cell addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self.Cells addObject:cell];
            [self.view addSubview:cell];
            
        }
    }
    //denote Mines 
    for (int i = 0; i<Mine; i++) {
        while (1) {
                int temp = arc4random()%(MaxCellNumber*MaxCellNumber);
            Cell *cell = [self.Cells objectAtIndex:temp];
            if (!cell.isMine) {
                cell.isMine = true;
                [self.Mines addObject:cell];
                NSLog(@"%d",temp);
                break;
                
            }
            
        }
    }
    //add round cells
    for(int i = 0;i<MaxCellNumber;i++){
        for (int j = 0; j<MaxCellNumber; j++) {
            for (int x = -1; x<=1; x++) {
                for (int y = -1; y<=1; y++) {
                    if (x==0&&y==0)                    
                        continue;
                    if (x + i<0 || x + i >=MaxCellNumber) continue;
                    if (y + j<0 || y + j >=MaxCellNumber) continue;
                        
                    Cell *cell = [Cells objectAtIndex:j*MaxCellNumber + i];
                    [cell addAroundCells:[Cells objectAtIndex:(x+i) + (y + j)*MaxCellNumber]];
                    
                }
            }
        }
    }
    
    //add time label
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - 60)/2,width + 44,  60, 30)];
    [self.timeLabel setText:@"00:00"];
    [self.view addSubview:self.timeLabel];
    
    [self StartTimer];
}

-(void)click:(id)sender{
    Cell *send = sender;
    [send open];
    if(send.isMine){
        for (Cell * cell in self.Mines) {
            [cell open];
        }
            [self StopTimer];
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"Game Over" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
    }
    else{
        Boolean win = true;
        for (Cell *cell in self.Cells) {
            if (cell.isMine == false&&cell.isOpen == false) {
                win = false;
                break;
            }
        }
        if (win) {
            [self StopTimer];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You Win!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
   
}



//Call This to Start timer, will tick every second
-(void) StartTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];

    self.timeLabel.text= timeNow;
}


- (void) StopTimer
{
    [timer invalidate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
