//
//  Cell.m
//  MinesSweeper
//
//  Created by Xiaodi Xing on 1/26/13.
//  Copyright (c) 2013 Xiaodi Xing. All rights reserved.
//

#import "Cell.h"
@interface Cell()
@property(nonatomic)int value;
@property(nonatomic,strong) NSMutableArray* aroundCells;
@end

@implementation Cell
@synthesize isMine;
@synthesize aroundCells;
@synthesize value;
@synthesize isOpen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageNamed:@"tile1.gif"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"tile2.gif"] forState:UIControlStateHighlighted];
        self.isMine = false;
        self.aroundCells = [[NSMutableArray alloc] initWithCapacity:8];
    }
    return self;
}

- (void)addAroundCells:(Cell *)cell{
    [self.aroundCells addObject:cell];
}

-(int) SetValue{
    int count = 0;
    if (self.isMine) {
        return -1;
    }
    for (Cell *cell in self.aroundCells) {
        if (cell.isMine) {
            ++count;
        }
    }
    return count;
}

-(int)open{
    self.value = [self SetValue];
    if (self.isOpen) {
        return self.value;
    }
    self.isOpen = YES;
    if(self.value > 0){
        [self setTitle:[NSString stringWithFormat:@"%i", self.value] forState:UIControlStateNormal];
        [self setTitle:[NSString stringWithFormat:@"%i", self.value] forState:UIControlStateHighlighted];
    }else if(value == -1){
        [self setTitle:@"m" forState:UIControlStateNormal];
        [self setTitle:@"m" forState:UIControlStateHighlighted];
    }
    [self setBackgroundImage:[UIImage imageNamed:@"tile2.gif"]  forState: UIControlStateNormal];
    
    if(value == 0){
        for(Cell * cell in self.aroundCells){
            [cell open];
        }    
    }
    
    return self.value;

}
@end
