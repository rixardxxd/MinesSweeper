//
//  Cell.h
//  MinesSweeper
//
//  Created by Xiaodi Xing on 1/26/13.
//  Copyright (c) 2013 Xiaodi Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UIButton
@property(nonatomic) Boolean isMine;
@property(nonatomic) Boolean isOpen;

-(void)addAroundCells:(Cell*)cell;
-(int) open;
@end
