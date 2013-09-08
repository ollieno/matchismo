//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jeroen Olthof on 05-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *flipHistory;
@end

@implementation CardMatchingGame

#define FLIP_COST 1;
#define MISMATCH_PENALTY 2;
#define MATCH_BONUS 4;

// lazy instantiation
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// lazy instantiation
-(NSMutableArray *)flipHistory
{
    if (!_flipHistory) _flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}

-(id) initWithCardCount:(NSInteger)cardCount usingDeck:(Deck *)deck {
    if (self = [super init]) {
        for (int i=0; i<cardCount;i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }
            else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        // this is going to be a flip
        Flip *flip = [[Flip alloc] init];
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.unplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        flip.score = matchScore * MATCH_BONUS
                        flip.match = YES;
                        self.score += flip.score;

                    } else {
                        otherCard.faceUp = NO;
                        flip.score = -MISMATCH_PENALTY;
                        flip.match = NO;
                        self.score -= flip.score;
                    }
                    [flip.cards addObject:otherCard];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
        [flip.cards addObject:card];
        [self.flipHistory addObject:flip];
    }
}

@end
