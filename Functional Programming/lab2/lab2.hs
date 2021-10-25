import GHC.Num(Natural)
-- cabal init in terminal

fizzbuzz :: Integer -> String
fizzbuzz x
    | mod x 3 == 0 && mod x 5  == 0 = "fizzbuzz"
    | mod x 5 == 0 = "buzz"
    | mod x 3 == 0 = "fizz"
    | otherwise = ""

-- fizzbuzz :: Integer -> String
-- fizzbuzz x =
--   if (mod x 15 == 0)
--     then "fizzbuzz"
--     else
--       if (mod x 3 == 0)
--         then "fizz"
--         else
--           if (mod x 5 == 0)
--             then "buzz"
--             else ""

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 2 = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
  fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

-- tribonacci :: Integer -> Integer
-- tribonacci n 
--     | n <= 2 = 1
--     | n == 3 = 2
--     | otherwise = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)

tribonacci :: Natural -> Natural
tribonacci 1 = 1
tribonacci 2 = 2
tribonacci 3 = 2
tribonacci n = 
    tribonacci (n - 1) + tribonacci (n - 2) + tribonacci (n - 3)

binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 k = 0
binomial n k = binomial (n-1) k + binomial (n-1) (k - 1)


--patern matching pe liste
funct :: [Integer] -> Integer 
funct (x : xs) = x

funct2 :: [Integer] -> [Integer] 
funct2 (x : xs) = xs

verifL :: [Int] -> Bool
verifL = undefined

takefinal :: [a] -> Int -> [a]          --a : accepta si intreg si char
takefinal a x = drop (length a - x) a

remove :: [Int] -> Int -> [Int]
remove ls n = take n ls ++ drop (n + 1) ls      --trb n si n + 1 ca sa fie indexat de la 0
-- Integer are minbound si maxbound mai mare decat Int

-- semiPareRec [0,2,1,7,8,56,17,18] == [0,1,4,28,9]
semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h : t)
  | even h = h `div` 2 : t'
  | otherwise = t'
  where
    t' = semiPareRec t

totalLen :: [String] -> Int
totalLen = undefined

f1 :: Double -> Double -> Double -> Double -> Double
f1 a b c x = a * x ^ 2 + b * x + c

a :: Integer -> Integer
a x = x * 2


myReplicate :: Int -> Int -> [Int]
myReplicate 0 v = []
myReplicate n v = v : myReplicate (n - 1) v

sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (h:t)
    |  odd h = h + sumImp t
    |  otherwise = sumImp t 


totallLen :: [String] -> Int 
totallLen [] = 0
totallLen(x : xs)
    | head x == 'A' = length x + totalLen xs
    | otherwise = totalLen xs