//
//  Flip.h
//  Matchismo
//
//  Created by Jeroen Olthof on 08-09-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flip : NSObject
@property (strong, nonatomic, readonly) NSMutableArray *cards;
@property (nonatomic, getter = isMatch) BOOL match;
@property (nonatomic) int score;
@end
