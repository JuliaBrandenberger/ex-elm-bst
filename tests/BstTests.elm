module BstTests exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, tuple, custom)
import Random exposing (Generator)
import Shrink exposing (Shrinker, merge, noShrink)
import Test exposing (..)
import BST exposing (..)

-- fuzzer to produce sorted BSTs
sortedBST : Fuzzer BST
sortedBST =
  let
    f x t = case t of
      Leaf -> singleton x
      Node n l r -> if x < n then Node n (f x l) r else if n < x then Node n l (f x r) else t

    generator : Generator BST
    generator = Random.map (List.foldl f empty) (Random.list 100 (Random.int -100 100))

    shrinker : Shrinker BST
    shrinker t =
      case t of
        Leaf -> noShrink Leaf
        Node n l r ->
          Shrink.map Node (noShrink n)
            |> Shrink.andMap (shrinker l)
            |> Shrink.andMap (shrinker r)
  in
    custom generator noShrink

bstTests : Test
bstTests =
  describe "Tests for BST module"

    [ describe "unit tests for isSorted"

      [ test "empty is sorted" <|
        \_ -> Expect.equal (isSorted empty) True

      , test "2 [1 3] is sorted" <|
        \_ -> Expect.equal (isSorted (Node 2 (singleton 1) (singleton 3))) True

      , test "3 [1 2] is not sorted" <|
        \_ -> Expect.equal (isSorted (Node 3 (singleton 1) (singleton 2))) False

      , fuzz (sortedBST) "sortedBST results are sorted" <|
        \t -> Expect.equal (isSorted t) True

      ]

    , fuzz (tuple (int, sortedBST)) "insert preserves sorting" <|
      \(x, t) ->
        Expect.true "Expected the BST to be sorted"
          <| isSorted (insert x t)

    -- add your tests here
    --, test "string describing test" <|
    --    \_ -> Expect.equal x y
    
    ]