vocale :: String -> Int
vocale "" = 0
vocale x =
    if head x `elem` "aeiouAEIOU" then 1 + vocale (tail x)
    else vocale (tail x)


factori :: Int -> [Int]
factori n = [x | x <- [1..n], mod n x == 0]


prim :: Int -> Bool

prim x = length (factori x) == 2


nrPrime :: Int -> [Int]
nrPrime n = [x | x <- [2..n], prim x]

myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 l1 l2 l3
    | null l1 || l2 == [] || l3 == [] = []
    | otherwise = (head l1, head l2, head l3) : myzip3 (tail l1) (tail l2) (tail l3)


myzip4 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip4 l1 l2 l3 = [(a, b, c) | (a, (b, c)) <- zip l1 (zip l2 l3)]


ordonataNat :: [Int] -> Bool 
ordonataNat [] = True 
ordonataNat [x] = True 
ordonataNat (x : y : xs) = and[x < y, ordonataNat(y : xs)]

-- ordonataNat (x : y : xs) = x < y && ordonataNat(y : xs)

ordonata :: [a] -> (a -> a -> Bool) -> Bool
ordonata [] ordine = True
ordonata [x] ordine = True
ordonata (x : y : xs) ordine = ordine x y && ordonata (y : xs) ordine


(*<*) :: (Int, Int) -> (Int, Int) -> Bool 
(a, b) *<* (c, d) = a >= c && b >= d

infixl 6 *<*        --ii dai precedenta operatorului si daca e infix sau nu. in forma infixata are asociativitate la dreapta


compuneList :: (b -> c) -> [(a -> b)] -> [(a -> c)]
compuneList f lf = [f.g | g <- lf]          -- f(g(x))

aplicaList :: a -> [(a -> b)] -> [b]
aplicaList x lf =[f x | f <- lf]
