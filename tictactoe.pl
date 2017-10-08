% Display board.
display([A,B,C,D,E,F,G,H,I]) :- write([A,B,C]),nl,
                                write([D,E,F]),nl,
                                write([G,H,I]),nl,nl.

% Winning predicates.
win(Token, Board) :- Board = [Token,Token,Token,_,_,_,_,_,_].
win(Token, Board) :- Board = [_,_,_,Token,Token,Token,_,_,_].
win(Token, Board) :- Board = [_,_,_,_,_,_,Token,Token,Token].
win(Token, Board) :- Board = [Token,_,_,Token,_,_,Token,_,_].
win(Token, Board) :- Board = [_,Token,_,_,Token,_,_,Token,_].
win(Token, Board) :- Board = [_,_,Token,_,_,Token,_,_,Token].
win(Token, Board) :- Board = [Token,_,_,_,Token,_,_,_,Token].
win(Token, Board) :- Board = [_,_,Token,_,Token,_,Token,_,_].

% Player moves.
makeMove([1,B,C,D,E,F,G,H,I], Token, [Token,B,C,D,E,F,G,H,I]).
makeMove([A,2,C,D,E,F,G,H,I], Token, [A,Token,C,D,E,F,G,H,I]).
makeMove([A,B,3,D,E,F,G,H,I], Token, [A,B,Token,D,E,F,G,H,I]).
makeMove([A,B,C,4,E,F,G,H,I], Token, [A,B,C,Token,E,F,G,H,I]).
makeMove([A,B,C,D,5,F,G,H,I], Token, [A,B,C,D,Token,F,G,H,I]).
makeMove([A,B,C,D,E,6,G,H,I], Token, [A,B,C,D,E,Token,G,H,I]).
makeMove([A,B,C,D,E,F,7,H,I], Token, [A,B,C,D,E,F,Token,H,I]).
makeMove([A,B,C,D,E,F,G,8,I], Token, [A,B,C,D,E,F,G,Token,I]).
makeMove([A,B,C,D,E,F,G,H,9], Token, [A,B,C,D,E,F,G,H,Token]).

xMove([1,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xMove([A,2,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xMove([A,B,3,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xMove([A,B,C,4,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xMove([A,B,C,D,5,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xMove([A,B,C,D,E,6,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xMove([A,B,C,D,E,F,7,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xMove([A,B,C,D,E,F,G,8,I], 8, [A,B,C,D,E,F,G,x,I]).
xMove([A,B,C,D,E,F,G,H,9], 9, [A,B,C,D,E,F,G,H,x]).
xMove(_,_,_) :- write("Invalid move."),nl.

% Helper functions to determine state of the game.
isFull(Board) :- not(member(1,Board)),
                 not(member(2,Board)),
                 not(member(3,Board)),
                 not(member(4,Board)),
                 not(member(5,Board)),
                 not(member(6,Board)),
                 not(member(7,Board)),
                 not(member(8,Board)),
                 not(member(9,Board)).

xWinsNext(Board) :- makeMove(Board,x,NewBoard),
                    win(x,NewBoard).

% Computer moves.
compMove(Board,NewBoard) :- makeMove(Board,o,NewBoard),
                            win(o,NewBoard), !.
compMove(Board,NewBoard) :- makeMove(Board,o,NewBoard),
                            not(xWinsNext(NewBoard)).
compMove(Board,NewBoard) :- makeMove(Board,o,NewBoard).
compMove(Board,NewBoard) :- isFull(Board), !,
                            write("It a tie!"), nl.

% Main play function.
play(Board) :- win(x,Board),
               write("X wins!"),nl.
play(Board) :- win(o,Board),
               write("O wins!"),nl.
play(Board) :- display(Board),
               read(N),
               write("You entered: "), write(N),nl,
               xMove(Board, N, NewBoardX),
               display(NewBoardX),
               compMove(NewBoardX,NewBoardO),
               play(NewBoardO).

% Execute go. to begin play.
go :- write("You will play as X. Enter box number to make your first move."), nl,
      play([1,2,3,4,5,6,7,8,9]).
