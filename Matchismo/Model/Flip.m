//
//  Flip.m
//  Matchismo
//
//  Created by Jeroen Olthof on 08-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import "Flip.h"
#import "Card.h"

@interface Flip()
@property (strong,nonatomic) NSMutableArray *cards;
@end;

@implementation Flip

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCardsObject:(Card *)card
{
    [self.cards addObject:card];
}

- (NSString *)description {
    NSString *description = @"";
    
    if (self.cards.count == 1) {
        Card *card = [self.cards lastObject];
        if (card.isFaceUp) {
            description = [NSString stringWithFormat: @"Flipped %@", [self.cards lastObject]];
        }
    }
    else if (self.match) {
        return [NSString stringWithFormat: @"matched %@ for %d points", [self.cards componentsJoinedByString:@" "], self.score];
    }
    else {
        return [NSString stringWithFormat: @"Mismatch %@ got %d penalty", [self.cards componentsJoinedByString:@" "], self.score];
    }
    return description;
}
@end
