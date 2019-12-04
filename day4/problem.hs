validLength :: String -> Bool
validLength s = length s == 6

twoAdjacent :: String -> Bool
twoAdjacent (x:y:xs) = x == y || twoAdjacent (y:xs)
twoAdjacent _ = False

nonDecreasing :: String -> Bool
nonDecreasing (x:y:xs) = x <= y && nonDecreasing (y:xs)
nonDecreasing _ = True

exactlyTwoAdjancent :: String -> Bool
exactlyTwoAdjancent (a:b:c:d:xs) = (b == c && a /= b && c /= d) || exactlyTwoAdjancent (b:c:d:xs)
exactlyTwoAdjancent _ = False

validPassword :: String -> Bool
validPassword s = validLength s && twoAdjacent s && nonDecreasing s

passwords :: Int -> Int -> [String]
passwords from to =  filter validPassword $ map show [from..to]

solve1 :: Int -> Int -> Int
solve1 from to = length $ passwords from to

solve2 :: Int -> Int -> Int
solve2 from to = length $ filter exactlyTwoAdjancent $ map (\s -> "." ++ s ++ ".") $ passwords from to

main = do
  putStrLn $ show $ solve1 171309 643603
  putStrLn $ show $ solve2 171309 643603
