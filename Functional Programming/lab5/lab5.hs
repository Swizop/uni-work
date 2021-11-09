-- operatorul $ il folosim ca sa impunem asociativitatea la dreapta ex. map ($3)  [ (4+), (10 *) ]
-- map ('elem` [2,3]) [1,2,3] -> aplica 1 elem 2 3, 2 elem 2 3 etc

-- firstEl :: [(a, b)] -> [a]
-- firstEl ls = map (\(f, s) -> f) ls

-- firstEl :: [(a, b)] -> [a]
-- firstEl ls = map fst ls

-- se poate scoate ls
firstEl :: [(a, b)] -> [a]
firstEl = map fst


sumList :: [[Int]] -> [Int]
sumList = map sum

prel2 :: [Int] -> [Int]
prel2 = map (\x -> if even x then x `div` 2 else x * 2)




f4 :: Char -> [[Char]] -> [[Char]]
f4 c = filter (c `elem`)

-- f3 :: Char -> [[Char]] -> [[Char]]
-- f3 c = filter (c `elem`)

-- f5 :: [Int] -> [Int]
-- f5 ls = map (\x -> x * x) (filter odd ls)


f5 :: [Int] -> [Int]
f5 = map (^2) . filter odd          --map (^2) e tot o functie (partial aplicata), filter odd e alta functie partial aplicata => le putem compune


f6 :: [Int] -> [Int]
f6 = map (\ls -> snd ls ^ 2) . filter (odd . fst) . zip [0..]

f61 :: [Int] -> [Int]
f61 = map ((^2) . snd) . filter (odd . fst) . zip [0..]


numaiVocale :: [[Char]] -> [[Char]]
numaiVocale = map (filter (`elem` "aeiou"))


myMap :: (a -> b) -> [a] -> [b]
myMap f ls = [f x | x <- ls]

-- recursiv
-- mymap _ [] = []
-- mymap f (x: xs) = f x : mymap f xs

myFilter :: (a-> Bool) -> [a] -> [a]
myFilter f ls = [x | x <- ls, f x]

-- myfilter _ [] = []
-- myf f (x:xs)
--  | f x = x : (myf f xs)
--  | otherwise = myfilter f xs



-- ?
-- f9 :: [Int] -> [Int]
-- f9 = (foldr (+) 0 ) . map (^2) . filter odd          

f10 :: [Bool] -> Bool 
f10 = foldr (&&) True 


f11a :: Char -> String -> String        --rmchar
f11a c = filter(/= c) 

f11b :: String -> String -> String
f11b "" ls = ls 
f11b (x : xs) ls = f11b xs (f11a x ls)      --f11a il scoate pe x din ls, ce ramane va fi parsat folosind restul din stringul initial din stanga


f11c :: String -> String -> String
f11c s1 s2 = foldr f11a s2 s1

-- f11c "ab" "abcd" => foldr rmChar "abcd" "ab" => "a" rmChar "b" rmChar "abcd" => "a" rmChar "acd" => "cd"
