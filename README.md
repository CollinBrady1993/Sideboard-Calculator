# Sideboard-Calculator
Code used to calculate the sideboard which maximizes the weighted average post sideboard deck score for Legacy Magic: The Gathering.

This code is being uploaded to demonstrate an intention to make it truely open source (likely migrating it to python) but for the moment I work/test faster in matlab so it's currently in that format. If you are really intereseted in running it but dont have a matlab licence then you can look into octave (https://www.gnu.org/software/octave/) which should be able to run the main .m file as I have not used any fancy matlab functions.

The goal of this code is to take a maindeck and metagame breakdown, along with scores for maindeck cards (called a card score) against each of the "meta" decks, and build a sideboard by taking a large list of potential sideboard cards with scores in each matchup and find the combination of sideboard cards which results in a post-sideboard deck configuration which maximizes a weighted sum of matchup scores (the sum of card scores for a given matchup) with weights equal to the metagame share of that matchup.

The code accomplishes this by taking a greedy aproach. At each iteration the algorithm checks a potential sideboard cards against a card in the current list (which begins empty) for a given matchup. If that card has an equal or greater card score in that matchup then a matchup score is calculated for all matchups and a weighted sum of matchup scores is calculated. If the new weighted sum is greater than the old weighted sum then the new sideboard card is swapped with the old sideboard card.

To account for the fact that in magic many sideboard cards are not actually wanted in large numbers a penalty is added to the card score of all sideboard cards beyond the first.

The algorithm completes after one complete cycling through of potential sideboard cards occurs with no changes to the sideboard.

The card scores are highly subjective and would be best done through crowdsourcing, having multiple people fill out their own personal opinions and then doing some sort of averaging.

The metagame breakdown included in the files is derived from the legacy pit open results with some small changes (https://docs.google.com/spreadsheets/d/1NTpJqzHyaRTnV6h6tneYo_Gh8jNGRb_1byaE9sJPmII/edit#gid=303790053)

Although I can make no concrete claim of convergence I have tested the algorithm by shifting the initial position (controlled by the variable shift in main.m) and have found that although the order of the sideboard cards change, the contents of the sideboard are consistent regardless of initial position, implying that it is reasonably robust.
