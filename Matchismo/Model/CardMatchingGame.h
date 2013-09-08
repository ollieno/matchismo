//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jeroen Olthof on 05-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Flip.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSInteger)cardCount
                usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSInteger)index;

@property (nonatomic,readonly) NSMutableArray *flipHistory;
@property (nonatomic,readonly) int score;

@end
