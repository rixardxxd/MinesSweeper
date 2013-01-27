//
//  GameStartViewController.h
//  MinesSweeper
//
//  Created by Xiaodi Xing on 1/25/13.
//  Copyright (c) 2013 Xiaodi Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameStartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *LevelControll;

- (IBAction)gameStart:(id)sender;
@end
