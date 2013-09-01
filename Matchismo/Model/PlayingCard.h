//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jeroen Olthof on 01-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuits;
+ (NSInteger)maxRank;

@end
