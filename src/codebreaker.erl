-module(codebreaker).

-export([start/0]).

% Define game parameters
-define(LENGTH, 5).
-define(MAX_TRIES, 12).
-define(NUM, "0123456789").

% Main run code
start() ->
    rand:seed(exsplus, {erlang:monotonic_time(), erlang:unique_integer(), erlang:phash2(self())}),
    Code = generate_code(?LENGTH),
    io:format("~n=== Codebreaker ===~n"),
    io:format("Guess the ~p number in the code using numbers ~p. Feedback: R = Right number and place; W = Right number, wrong place. You have ~p tries.", [?LENGTH, ?NUM, ?MAX_TRIES]),
    game_loop(Code, ?MAX_TRIES).
    
% Game workings
% Create code to guess
generate_code(N) ->
    generate_code(N, []).
generate_code(0, Acc) ->
    lists: reverse(Acc);
generate_code(N, Acc) ->
    Nums = ?NUM,
    Index = rand:uniform(length(Nums)),
    Num = lists:nth(Index, Nums),
    generate_code(N - 1, [Num | Acc]).

% Loop through game until out of tries, correct guess, or user termination
game_loop(_Code, 0) ->
    % Out of tries
    io:format("Game over. Code: ~s~n", [_Code]);
game_loop(Code, TriesLeft) ->
    io:format("~n~p tries left. Enter a guess:", [TriesLeft]),
    case io:get_line("") of
        % If terminated
        eof ->
            io:format("Goodbye.~n"),
            ok;
        % Get guess and check for correctness
        Line ->
            Guess = string:trim(Line),
            case valid_guess(Guess) of
                false ->
                    io:format("Invalid guess."),
                    game_loop(Code, TriesLeft);
                true ->
                    case Guess == Code of
                        true ->
                            io:format("Correct! You win! Code: ~s~n", [Code]);
                        false ->
                            {R, W} = score(Code, Guess),
                            io:format("Feedback: ~p R, ~p W~n", [R, W]),
                            game_loop(Code, TriesLeft - 1)
                    end    
            end        
    end.        

% Check if valid guess
valid_guess(Guess) ->
    length(Guess) =:= ?LENGTH andalso
    lists:all(fun(C) -> lists:member(C, ?NUM) end, Guess).

% Check if numbers are in code
score(Code, Guess) ->
    Pairs = lists:zip(Code, Guess),
    Rights = [C || {C, G} <- Pairs, C =:= G],
    R = length(Rights),
    CodeRest = [C || {C, G} <- Pairs, C =/= G],
    GuessRest = [G || {C, G} <- Pairs, C =/= G],
    W = count_wrongs(CodeRest, GuessRest),
    {R, W}.

count_wrongs(CodeRest, GuessRest) ->
    count_wrongs(CodeRest, GuessRest, 0).

count_wrongs(_CodeRest, [], Acc) ->
    Acc;

count_wrongs(CodeRest, [G | T], Acc) ->
    case lists:member(G, CodeRest) of
        true ->
            NewCode = remove_first(G, CodeRest),
            count_wrongs(NewCode, T, Acc + 1);
        false ->
            count_wrongs(CodeRest, T, Acc)
    end.

remove_first(X, [X | T]) ->
    T;

remove_first(X, [H | T]) ->
    [H | remove_first(X, T)];

remove_first(_X, []) ->
    [].
