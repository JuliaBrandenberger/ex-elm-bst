module BST exposing (..)

import Playground exposing (..)

---------------------
-- Data definition --
---------------------

type BST
  = Leaf
  | Node Int BST BST

empty : BST
empty = Leaf

singleton : Int -> BST
singleton n = Node n Leaf Leaf

---------------
-- Rendering --
---------------

-- Width of leaves
leafWidth = 5

-- Shape defining how leaves are rendered.
leafShape : Shape
leafShape = square black leafWidth

-- Constant that represents how much space to allow for a rendered node
-- when calculating rendered tree width.
nodeSize : Float
nodeSize = 16

-- How much space to insert between rendered subtrees.
nodePadding : Float
nodePadding = 50

-- Function for rendering the value part of a node without subtrees.
nodeShape : Int -> Shape
nodeShape n =
  group
    [ circle white nodeSize
    , String.fromInt n
        |> words black
    ]

-- Amount of vertical distance between layers of the tree.
layerHeight : Float
layerHeight = 50

-- Calculates how much horizontal space a tree takes up.
width : BST -> Float
width t = widthLeft t + widthRight t

-- Draws lines connecting a node to its children.
drawLines : BST -> Shape
drawLines t =
  case t of
    Leaf -> group []
    Node _ l r ->
      let
        lineWidth = 1
        -- vertical offset
        h = layerHeight
        -- horizontal offset
        lw = widthRight l + (nodePadding / 2)
        rw = (nodePadding / 2) + widthLeft r
        -- line length
        ld = sqrt (lw^2 + h^2)
        rd = sqrt (rw^2 + h^2)
        -- rotation angle
        lr = (atan2 -h -lw) * 180 / pi
        rr = (atan2 -h rw) * 180 / pi
      in
        group
          [ -- left
            group [ rectangle black ld lineWidth |> moveRight (ld / 2) ]
              |> rotate lr
          , --right
            group [ rectangle black rd lineWidth |> moveRight (rd / 2) ]
              |> rotate rr
          ]

-- Calculates width to the right of the center line.
widthRight : BST -> Float
widthRight t =
  case t of
    Leaf ->
      leafWidth / 2

    Node _ _ r ->
      width r + (nodePadding / 2)

-- Calculates width to the left of the center line.
widthLeft : BST -> Float
widthLeft t =
  case t of
    Leaf ->
      leafWidth / 2

    Node _ l _ ->
      width l + (nodePadding / 2)


-- Render a given BST to a Shape for displaying.
render : BST -> Shape
render t =
  case t of
    Leaf ->
      leafShape

    Node n l r ->
      group
        [ drawLines t
        , nodeShape n
        , render l
            |> moveDown layerHeight
            |> moveLeft (widthRight l + (nodePadding / 2))
        , render r
            |> moveDown layerHeight
            |> moveRight (widthLeft r + (nodePadding / 2))
        ]

-- Assuming a BST is sorted, returns the maximum value from the tree.
-- If the tree is not sorted, this function doesn't work, as it just
-- always returns the rightmost node value.
maxVal : BST -> Maybe Int
maxVal t =
  case t of
    Leaf ->
      Nothing

    Node n _ r ->
      maxVal r
        |> Maybe.withDefault n
        |> Just

-- Predicate that checks whether a BST is correctly sorted.
isSorted : BST -> Bool
isSorted t =
  case t of
    Leaf ->
      True
    
    Node n l r ->
      if isSorted l && isSorted r
        then
          case (maxVal l, maxVal r) of
            (Nothing, Nothing) ->
              True
            
            (Just ln, Nothing) ->
              ln < n

            (Nothing, Just rn) ->
              n < rn

            (Just ln, Just rn) ->
              ln < n && n < rn
        else
          False

---------------
-- Exercises --
---------------

-- insert should add a new value to the tree, while mantaining the
-- invariant that all values to the left of a node are less than its
-- value, and all values to the right of a node are greater than its
-- value. Inserting a value into a BST that already has a node with
-- that value does nothing (it returns the original tree unchanged).
insert : Int -> BST -> BST
insert n t = t

-- fromList should take a list of numbers and produce a tree that has
-- a node for each value that was in the list.
fromList : List Int -> BST
fromList list = Leaf

-- toList should take a BST and produce a list that contains all of the
-- values from the tree in order. This means that if the input BST is
-- correctly sorted, then the output list is sorted as well. This means
-- that the first elements in the list is less than all of the rest in
-- the list, and that property holds for all sublists as well.
toList : BST -> List Int
toList t = []