import Data.Char
rotate :: Int -> [Char] -> [Char]
rotate n ls
    | n <= 0 = error "n egal sau mai mic decat 0"
    | n >= length ls = error "n egal sau mai mare decat lungimea listei"
    | otherwise = drop n ls ++ take n ls


makeKey :: Int -> [(Char, Char)]
makeKey n = zip ['A'..'Z'] (rotate n ['A'..'Z'])

lookUp :: Char -> [(Char, Char)] -> Char
lookUp x [] = x
lookUp x ((x1, x2):xs)
    | x == x1 = x2
    | otherwise = lookUp x xs


encipher :: Int -> Char -> Char 
encipher x ch = lookUp ch (makeKey x)

normalize :: String -> String
normalize str = map toUpper $ filter (`elem` (['A'..'Z'] ++ ['a'..'z'] ++ ['0'..'9'])) str

encipherStr :: Int -> String -> String 
encipherStr x str = map (encipher x) $ normalize str

-- encipherStr x str = map (encipher x) (normalize str)
-- $ face ce e in dreapta  asociativ la dreapta si nu mai trb sa folosim paranteze
-- ia ce e cel mai in dreapta si il aplica in stanga

reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey = map (\(x, y) -> (y, x)) 


decipherStr :: Int -> String -> String
decipherStr n str = map (decipher n) $ filter (`elem` ['0' .. '9'] ++ ['A' .. 'Z'] ++ [' ']) str
