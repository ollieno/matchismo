//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jeroen Olthof on 28-08-13.
//  Copyright (c) 2013 Jeroen Olthof. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Flips updated to %d", self.flipCount);
}

- (PlayingCardDeck *)deck
{
    if (!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (IBAction)flipCard:(UIButton *)sender {
    if (!sender.isSelected)
    {
        Card *card = [self.deck drawRandomCard];
        [sender setTitle:card.contents forState:UIControlStateSelected];
    }
    sender.selected = !sender.isSelected;
    self.flipCount++;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
