# Elm exercise: binary search trees

This repository has some exercises for implementing
operations on binary search trees.

## Getting started

In your terminal, use
`git clone https://github.com/colinlogue/ex-elm-bst.git`
to create a local copy of this repository. This will create
a new directory called `ex-elm-bst`.

Use `cd` to move into the new directory. From here you can
use `elm-test` to run your tests. You can also use
`elm reactor &` (note the ampersand - that tells it to run
in the background) and then open up the link it gives you
to access the Elm development page.

From the reactor page, navigate to `src/Main.elm` to see an
interactive page where you can create binary search trees.
At first, this won't really do anything - you will need to
implement the `insert` function in `src/BST.elm` for it to
work.

## Exercises

There are three (as of this writing - I might add more)
function stubs at the bottom of `src/BST.elm` that I've
left as exercises. The comments above each function
describe the intended bahavior.

You should write some unit tests in `tests/BstTests.elm`
and you can use the reactor page to visually check that the
insert function works correctly.