//
//  Card.h
//  Matchismo
//
//  Created by Jeroen Olthof on 01-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *) otherCards;

@end
