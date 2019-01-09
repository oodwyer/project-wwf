# project-

The vast majority of the code is contained in one master function, MainBoard.m, which plots the board, buttons, tiles, and visuals initially and then uses callbacks for each turn to submit a word, refill players’ docks, or skip a turn. I faced challenges with the fact that it is difficult to get results from callbacks, and I needed data such as returning tiles, remaining tiles, or number of points from each word, so I kept our callback functions within one large function so that global variables could be referenced bet en functions. The one outer function, wordDB, contains the “wordData,” which is a database of 98 numbers that each map to the 98 different tiles used. The function is called once at the beginning to initially assign the two players docks and once tiles are used, they are removed from the wordData variable until none are remaining. The tiles are then visually plotted using the “dockPlot” callback function. One challenge I faced with the tiles was that a single handle can only be plotted once, so even though there were, for example, twelve “E” tiles, I assigned a different number and different handle to each in order for it to be able to plot. The turn variable represents whose turn it is and changes automatically once a valid word has been submitted and the points have been updated, and the “get new tiles” button has been selected.

I used three callback functions using MouseButton control functions to pick up, drag, and drop the tiles in set locations. I kept track of the locations of tiles using a matrix, p1Board, containing the locations of each of the tiles, and a matrix of zeros, MovingTiles, that had a 1 in the location of a tile that was under user control. Any tile under user control would move with the mouse location until it was dropped, and its position in MovingTiles was reset to zero. The xypos matrix keeps track of only the current letters being submitted so that each word, when submitted, could be scored individually before checking surrounding tiles using p1Board to see if all adjacent words were valid words. Xypos is reset to all zeros after each turn.

To score words, one master function is used, wordCheck. WordCheck is called when the submit word button is pressed. First, it checks special cases such as when a single letter is submitted or to confirm that characters have been submitted and are within the same line. Then, it checks whether the word is horizontal or vertical. It finds the starting row and column of the word, converts it to a vector, and converts it to letters based on which letters the numbers of the tiles are mapped to. It is then compared to each entry in a text file, basically a dictionary, to confirm whether or not is an existing word. Once confirmed that it is a word, it calculates points based on letter point values and the positions of the tiles on the board using a “board” matrix with values mapped to locations on the board and a decision loop. Then, the words must be compared to the words they are connected to, so it must check on both sides of the word and both sides of every letter to ensure they are all words and to give credit for all points received. Throughout the wordCheck, if any word is not a valid word or if the tiles have not been placed properly, an error variable will become 1, and at the end, if error is equal to one, no points will be received and the player will be instructed to submit another word. The points are updated through textboxes that are mapped using the “num2str” functionality to the variables p2points and p3points, which represent player 1 and player 2.

Finally, the game ends when all tiles have been used or when turns have been skipped three times in a row, which is tracked in a callback function. The p2points and p3points variables will be compared to determine the winner. The game can be quit at any time by clicking the quit game button, which just uses “close all” to exit out of the figure window.