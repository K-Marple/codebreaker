# Codebreaker

Codebreaker allows players to guess a 5 digit number code within 12 tries, giving feedback based on guess each time to guide the player in their next guess.

## Instructions for Build and Use

[Software Demo](https://www.kaltura.com//p/1157612/embedPlaykitJs/uiconf_id/56813562?iframeembed=true&entry_id=1_dej00h2x)

Steps to build and/or run the software:

In terminal run:

1. rebar3 compile
2. rebar3 shell
3. codebreaker:start().

Instructions for using the software:

1. Make a guess by entering 5 numbers in the terminal
2. Use feedback received to alter guess until correct or out of tries
3. Play again

## Development Environment

To recreate the development environment, you need the following software and/or libraries with the specified versions:

- Erlang 16.3
- Rebar3 3.27.0
- IDE (VS Code)

## Useful Websites to Learn More

I found these websites useful in developing this software:

- [Erlang Tutorial](https://www.tutorialspoint.com/erlang/index.htm)
- [Erlang Random](https://www.erlang.org/docs/20/man/random)

## Future Work

The following items I plan to fix, improve, and/or add to this project in the future:

- [ ] Add another game (tic-tac-toe)
- [ ] Allow user to pick difficulty level
