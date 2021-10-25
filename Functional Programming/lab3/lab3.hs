
import Data.Char
vocale :: String -> Int

vocale "" = 0

vocale x =
    if elem (head x) "aeiouAEIOU" then 1 + vocale (tail x)
    else vocale (tail x)



nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (x:xs)
    | x == reverse x = vocale x + nrVocale xs
    | otherwise = nrVocale xs


f :: Integral a => a -> [a] -> [a]

f a ls

    |null ls =[]

    |even (head ls)  = head ls : a : f a (tail ls)

    |otherwise = head ls : f a (tail ls)


divizori :: Integral a => a -> [a]
divizori a = [x | x <- [1..a], a `mod` x == 0]


listadiv :: Integral a => [a] -> [[a]]
listadiv ls = [divizori x | x <- ls]


inInterval :: Integer -> Integer -> [Integer] -> [Integer]
inInterval x y ls = [z | z <- ls, x <= z && z <= y]

inIntervalRec :: Integer -> Integer -> [Integer] -> [Integer]
inIntervalRec x y ls
    |null ls = []
    |x <= head ls && y >= head ls = head ls : inIntervalRec x y (tail ls)
    |otherwise = inIntervalRec x y (tail ls)


pozitiveRec :: [Int] -> Int

pozitiveRec ls

    | null ls = 0

    | head ls > 0 = 1 + pozitiveRec (tail ls)

    | otherwise = pozitiveRec (tail ls)



pozitiveComp :: [Int] -> Int

pozitiveComp ls = sum [1 | x <- ls, x > 0]

pozitii' :: Int -> [Int] -> [Int]
pozitii' poz ls
    | null ls = []
    | odd (head ls) = poz : pozitii' (poz + 1) (tail ls)
    | otherwise = pozitii' (poz + 1) (tail ls)

pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec ls = pozitii' 0 ls


pozImpComp :: [Int] -> [Int]
pozImpComp ls = [s | x <- zip ls [0..], let (f, s) = x, odd f]


mult :: [Char] -> Int
mult sir 
    | null sir = 1
    | isDigit x = digitToInt x * mult (tail sir)
    | otherwise = mult (tail sir)
    where x = head sir

multComp :: [Char] -> Int 
multComp sir = product [digitToInt x | x <- sir, isDigit x]