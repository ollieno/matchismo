//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jeroen Olthof on 01-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // because we provide getter and setter

- (int)match:(NSArray *)otherCards
{
    int score = 0 ;
    int suitMatchCount = 0;
    int rankMatchCount = 0;

    for (PlayingCard *otherCard in otherCards) {
        if ([otherCard.suit isEqualToString:self.suit]) {
            suitMatchCount++;
        }
        if (otherCard.rank == self.rank)
        {
            rankMatchCount++;
        }
    }
    // if the suitMatchCount is equal to the amount of otherCards
    // We have a complete match on suit.
    // Same goes for rank
    if (suitMatchCount == otherCards.count)
    {
        // match by suits
        score = 1 * otherCards.count;
    }
    if (rankMatchCount == otherCards.count) {
        score = 4 * otherCards.count;
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank {
    return [self rankStrings].count -1;
}

@end
