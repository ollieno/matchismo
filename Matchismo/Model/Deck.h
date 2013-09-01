//
//  Deck.h
//  Matchismo
//
//  Created by Jeroen Olthof on 01-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
