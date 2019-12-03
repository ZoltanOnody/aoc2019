module Example exposing (..)

import Array exposing (Array)
import Expect exposing (Expectation)
import Test exposing (..)


parseOperation: Int -> Maybe (Int -> Int -> Int)
parseOperation op =
  case op of
    1 -> Just (+)
    2 -> Just (*)
    _ -> Nothing


find: List Int -> Int -> Int -> Maybe Int
find lst noun verb =
    Array.fromList lst
     |> Array.set 1 noun 
     |> Array.set 2 verb
     |> (\arr -> calculate arr 0)


combWith: Int -> Int -> List (Int, Int)
combWith upTo num =
   List.map (Tuple.pair num) (List.range 0 upTo)


comb: Int -> List (Int, Int)
comb x =
   List.map (combWith <| x-1) (List.range 0 (x-1)) |> List.foldr (++) []


calculate: Array Int -> Int -> Maybe Int
calculate array start = 
    let
      op = Array.get start array |> Maybe.andThen parseOperation
      first = Array.get (start + 1) array |> Maybe.andThen (\i -> Array.get i array) |> Maybe.withDefault 0
      second = Array.get (start + 2) array |> Maybe.andThen (\i -> Array.get i array) |> Maybe.withDefault 0
      answerIndex = Array.get (start + 3) array |> Maybe.withDefault 0
    in
      case op of
        Just operation ->
            calculate (Array.set answerIndex (operation first second) array) (start + 4)
        Nothing -> Array.get 0 array


solve1: List Int -> Maybe Int
solve1 lst = find lst 12 2

solve2: List Int -> Maybe (Int, Int)
solve2 lst =
   let
      filter lst2 (noun, verb) =
        if (find lst2 noun verb) == Just 19690720 then Just (noun, verb) else Nothing
   in
     List.filterMap (filter lst) (comb 100) |> List.head


input = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,19,10,23,2,10,23,27,1,27,6,31,1,13,31,35,1,13,35,39,1,39,10,43,2,43,13,47,1,47,9,51,2,51,13,55,1,5,55,59,2,59,9,63,1,13,63,67,2,13,67,71,1,71,5,75,2,75,13,79,1,79,6,83,1,83,5,87,2,87,6,91,1,5,91,95,1,95,13,99,2,99,6,103,1,5,103,107,1,107,9,111,2,6,111,115,1,5,115,119,1,119,2,123,1,6,123,0,99,2,14,0,0]


suite : Test
suite =
    describe "unittests"
    [ test "example1" (\_ -> Expect.equal (calculate (Array.fromList [1,0,0,0,99]) 0) (Just 2))
    , test "example2" (\_ -> Expect.equal (calculate (Array.fromList [2,3,0,3,99]) 0) (Just 2))
    , test "example3" (\_ -> Expect.equal (calculate (Array.fromList [2,4,4,5,99,0]) 0) (Just 2))
    , test "example4" (\_ -> Expect.equal (calculate (Array.fromList [1,1,1,4,99,5,6,0,99]) 0) (Just 30))
    , test "combinations of 3" (\_ -> Expect.equal (comb 2) [(0, 0), (0, 1), (1, 0), (1, 1)])
    , test "solution1" (\_ -> Expect.equal (solve1 input) (Just 4090701))
    , test "solution2" (\_ -> Expect.equal (solve2 input) (Just (64, 21)))
    ]
