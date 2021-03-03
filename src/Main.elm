module Main exposing (main)

import BST exposing (BST)
import Playground exposing (..)

type alias Memory =
  { tree : BST
  , nodeVal : Int
  , enterHeld : Bool
  }

defaultNodeVal : Int
defaultNodeVal = 50

initialMemory : Memory
initialMemory =
  { tree = BST.empty
  , nodeVal = defaultNodeVal
  , enterHeld = False
  }

view : Computer -> Memory -> List Shape
view _ mem =
  [ group
      [ "new node value: " ++ String.fromInt mem.nodeVal
          |> words black
          |> moveUp 15
      , "hold up arrow to increment, down to decrement, enter to add to tree"
          |> words black
      ]
      |> moveUp 400
  , BST.render mem.tree
  ]

update : Computer -> Memory -> Memory
update comp mem =
  if comp.keyboard.enter
    then
      { tree = if mem.enterHeld then mem.tree else BST.insert mem.nodeVal mem.tree
      , nodeVal = mem.nodeVal
      , enterHeld = True
      }
    else
      { tree = mem.tree
      , nodeVal =
          if comp.keyboard.up == True
            then mem.nodeVal + 1
            else if comp.keyboard.down == True
              then mem.nodeVal - 1
              else mem.nodeVal
      , enterHeld = False
      }

main = game view update initialMemory