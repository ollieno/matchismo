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
@property (nonatomic) int matchCount;
@property (strong, nonatomic) NSMutableArray *flipHistory;
@property (nonatomic) BOOL started;
@end

@implementation CardMatchingGame
@synthesize cardsInMatch = _cardsInMatch;


#define FLIP_COST 1;
#define MISMATCH_PENALTY 2;
#define MATCH_BONUS 4;

// only allow 2 or 3 cards in match
- (void)setCardsInMatch:(int)num {
    if (num==2 || num==3)
    {
        _cardsInMatch = num;
    }
}

-(int)cardsInMatch {
    if (!_cardsInMatch) {
        _cardsInMatch = 2;
    }
    return _cardsInMatch;
}

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

-(id) initWithCardCount:(NSInteger)cardCount
              usingDeck:(Deck *)deck
   numberOfCardsInMatch:(int)cardsInMatch {
    
    if (self = [super init]) {
        self.started = NO;
        self.cardsInMatch = cardsInMatch;
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
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    self.started = YES;
    
    if (!card.isUnplayable)
    {
        // Ok, card is playable so it's going to be a flip
        Flip *flip = [[Flip alloc] init];
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
               if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                   [otherCards addObject:otherCard];
               }
            }
            // -1 because the current flipped cards is not in the otherCards
            if (otherCards.count == self.cardsInMatch - 1)
            {
                // match the other cards on the current card
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    flip.score = matchScore * MATCH_BONUS
                    flip.match = YES;
                    self.score += flip.score;
                }
                else {
                    flip.score = -MISMATCH_PENALTY;
                    flip.match = NO;
                    self.score -= flip.score;
                }
                for (Card *otherCard in otherCards) {
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                    } else {
                        otherCard.faceUp = NO;
                    }
                    [flip.cards addObject:otherCard];
                }
            }
        }
        self.score -= FLIP_COST;
        card.faceUp = !card.isFaceUp;
        [flip.cards addObject:card];
        [self.flipHistory addObject:flip];
    }
}

@end
