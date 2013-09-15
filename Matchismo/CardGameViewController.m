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
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSwitch;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    NSInteger numberOfCardsInMatch = (self.gameTypeSwitch.selectedSegmentIndex == 1) ? 2 : 3;
    if (!_game) _game = [[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                           usingDeck:[[PlayingCardDeck alloc] init]
                                                numberOfCardsInMatch:numberOfCardsInMatch] init];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI {
    self.statusLabel.text = @"";
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d", self.game.score];
    }
    if (self.game.flipHistory.count) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@",[self.game.flipHistory lastObject]];
    }
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipHistory.count];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}

- (IBAction)resetButton {
    self.game = nil;
    [self updateUI];
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
