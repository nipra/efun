-module(my_module).

-export([print/1, print2/1, either_or_both/2, either_or_both2/2, area/1,
         either_or_both3/2, area2/1, sign/1, sign2/1, yesno/1,
         some_unsafe_function/1, call_some_unsafe_function/1, read_file/1,
         sum/1, do_sum/1,
         rev/1]).

%% -record(customer, {name="<anonymous>", address, phone}).

print(Term) ->
    io:format("The value of Term is: ~p.~n", [Term]).

print2(Term) ->
    io:format("The value of Term is: ~w.~n", [Term]).

either_or_both(true, _) ->
    true;
either_or_both(_, true) ->
    true;
either_or_both(false, false) ->
    false.

either_or_both2(true, B) when is_boolean(B) ->
    true;
either_or_both2(A, true) when is_boolean(A) ->
    true;
either_or_both2(false, false) ->
    false.

area({circle, Radius}) ->
    Radius * Radius * math:pi();
area({square, Side}) ->
    Side * Side;
area({rectangle, Height, Width}) ->
    Height * Width.

area2(Shape) ->
    case Shape of
        {circle, Radius} ->
            Radius * Radius * math:pi();
        {square, Side} ->
            Side * Side;
        {rectangle, Height, Width} ->
            Height * Width
    end.

either_or_both3(A, B) ->
    case {A, B} of
        {true, B} when is_boolean(B) ->
            true;
        {A, true} when is_boolean(A) ->
            true;
        {false, false} ->
            false
    end.

sign(N) when is_number(N) ->
    if
        N > 0 ->
            positive;
        N < 0 ->
            negative;
        true ->
            zero
    end.

sign2(N) when is_number(N) ->
    case dummy of
        _ when N > 0 ->
            positive;
        _ when N < 0 ->
            negative;
        _ when true ->
            zero
    end.

yesno(F) ->
    case F(true, false) of
        true -> io:format("yes~n");
        false -> io:format("no~n")
    end.

%% fun ({circle, Radius}) ->
%%         Radius * Radius * math:pi();
%%     ({square, Side}) ->
%%         Side * Side;
%%     ({rectangle, Height, Width}) ->
%%         Height * Width
%% end.

%% yesno(fun (A, B) -> A or B end)


some_unsafe_function(SoUnsafe) ->
    case SoUnsafe of
        throw_oops ->
            throw(oops);
        throw_other ->
            throw("Yes I was thrown!");
        exit ->
            exit("Feeling bad :-(");
        error ->
            erlang:error("I'm so error prone.")
    end.


call_some_unsafe_function(X) ->
    try
        some_unsafe_function(X)
    catch
        oops -> got_throw_oops;
        throw:Other -> {got_throw, Other};
        exit:Reason -> {got_exit, Reason};
        error:Reason -> {got_error, Reason}
    end.


read_file(File) ->
    {ok, FileHandle} = file:open(File, read),
    try
        file:read_file(FileHandle)
    catch
        error:Reason -> {got_error, Reason}
    after
        file:close(FileHandle)
    end.


sum(0) ->
    0;
sum(N) ->
    sum(N - 1) + N.


do_sum(N) ->
    do_sum(N, 0).


do_sum(0, Total) ->
    Total;
do_sum(N, Total) ->
    do_sum(N - 1, Total + N).


rev([]) ->
    [];
rev([X]) ->
    [X];
rev([A | [B | TheRest]]) ->
    not_yet_implemented.
