import Data.Char
f1 :: Int -> Int -> Bool
f1 x y = x == y

-- f1 :: (Int, Char, String) -> String
-- f1 
data Person = Name | Phone

-- data Airline = Ab | Bc
-- data Vehicle = Plane Airline

-- f :: [Int] -> Int
-- f xs = sum [even x | x <- xs]


f3 list = let (x1, x2):xs = list in x1 + x2
--18
--f4 x y = if x > y then x * x

f4 0 x = []
f4 n x = x : f4 (n - 1) x

(***) :: [a] -> [a] -> Bool
(***) ls ys = True

-- f6 :: Integral a => [a] -> Bool
-- f6 xs = foldl (+) 0 [x `mod` 2 == 0 | x <- xs]



-------------------------------------------------------------------------------------------------------------------------

-- lab 1
f11 :: Num a => a -> a -> a
f11 x y = x * x + y * y
f12 :: Int -> String
f12 x = if even x then "par" else "impar"
f13 :: Int -> Int
f13 x = if x <= 1 then 1 else x * f13 (x - 1)
f14 :: Int -> Int -> Bool
f14 x y = x > 2 * y


-- lab 2
-- Să se scrie o funct, ie poly2 care are patru argumente de tip Double, a,b,c,x s, i calculează a*xˆ2+b*x+c.
f21 :: Double -> Double -> Double -> Double -> Double
f21 a b c x = a * x * x + b * x + c
-- o funct, ie eeny care întoarce “eeny” pentru input par s, i “meeny” pentru input impar.
f22 :: Int -> String
f22 x
    | even x = "eeny"
    | otherwise = "meeny"
-- Să se scrie o funct, ie fizzbuzz care întoarce “Fizz” pentru numerele divizibile cu 3, “Buzz” pentru numerele divizibile cu 5 s, i “FizzBuzz” pentru numerele divizibile cu ambele. Pentru orice alt număr => ""
f23 :: Int -> String
f23 x
    | x `mod` 15 == 0 = "FizzBuzz"
    | x `mod` 3 == 0 = "Fizz"
    | x `mod` 5 == 0 = "Buzz"
    | otherwise = ""

-- Să se implementeze functia tribonacci
f24 :: Int -> Int
f24 x
    | x <= 0 = error "Number must be >0"
    | x < 3 = 1
    | x == 3 = 2
    | otherwise = f24 (x - 1) + f24 (x - 2) + f24 (x - 3)

-- Să se scrie o funct, ie care calculează coeficient, ii binomiali, folosind recursivitate.
f25 :: Int -> Int -> Int
f25 _ 0 = 1
f25 0 _ = 0
f25 n k = f25 (n-1) k + f25 (n-1) (k-1)


-- verifL - verifică dacă lungimea unei liste date ca parametru este pară
f26 :: [a] -> Bool
f26 xs = even (length xs)
-- takefinal - pentru o listă dată ca parametru s, i un număr n, întoarce lista cu ultimele n elemente. Dacă lista are mai putin de n elemente, se intoarce lista nemodificată.
f27 :: [a] -> Int -> [a]
f27 [] _ = []
f27 l@(x : xs) n = if length l <= n then l else f27 xs n



-- pentru o listă s, i un număr n se întoarce lista din care se s, terge elementul de pe pozit, ia n.
f28 :: [a] -> Int -> [a]
f28 [] _ = []
f28 ls n = take n ls ++ drop (n + 1) ls


-- - pentru un întreg n si o valoare v întoarce lista de lungime n ce are doar elemente egale cu v
f29 :: Int -> a -> [a]
f29 0 _ = []
f29 n v = v : f29 (n - 1) v
-- pentru o listă de numere întregi, calculează suma valorilor impare.
f210 :: [Int] -> Int
f210 [] = 0
f210 (x:xs) = if odd x then x + f210 xs else f210 xs
-- pentru o listă de s, iruri de caractere, calculează suma lungimilor s, irurilor care încep cu 'A'
f211 :: [String] -> Int
f211 [] = 0
f211 (l:ls) = if not (null l) && l !! 0 == 'A' then length l + f211 ls else f211 ls


-- lab 3
-- Sa se scrie o func  ̆ t,ie nrVocale care pentru o lista de  ̆ s,iruri de caractere, calculeaza num  ̆ arul  ̆total de vocale ce apar în cuvintele palindrom.
f31 :: [String] -> Int
f31 [] = 0
f31 (x:xs) = if x == reverse x then nrVocale x + f31 xs else f31 xs
    where
        nrVocale "" = 0
        nrVocale (y:ys) = if y `elem` "AEIOUaeiou" then 1 + nrVocale ys else nrVocale ys

-- Sa se scrie o func  ̆ t,ie care primes,te ca parametru un numar ̆ si o lista de întregi,  ̆ s,i adauga ̆elementul dat dupa fiecare element par din list  ̆ a.
f32 :: Int -> [Int] -> [Int]
f32 _ [] = []
f32 x (l:ls) = if even l then l : x : f32 x ls else l : f32 x ls
-- Sa se scrie o func  ̆ t,ie care are ca parametru un numar întreg  ̆ s,i determina lista de divizori ai  ̆acestui numar.
f33 :: Int -> [Int]
f33 x = [i | i <- [1..x], x `mod` i == 0]
-- Sa se scrie o func  ̆ t,ie care are ca parametru o lista de numere întregi  ̆ s,i calculeaza lista listelor  ̆de divizori.
f34 :: [Int] -> [[Int]]
f34 ls = [f33 y | y <- ls]

-- Scriet,i o funct,ie care date fiind limita inferioara ̆ s,i cea superioara (întregi) a unui interval  ̆închis s,i o lista de numere întregi, calculeaz  ̆ a lista numerelor din list  ̆ a care apartin intervalului.
f35 :: Int -> Int -> [Int] -> [Int]
f35 x y ls = [i | i <- ls, x <= i && i <= y]
-- Scriet,i o funct,ie care numar ̆ a câte numere strict pozitive sunt într-o list  ̆ a dat  ̆ a ca argument.
f36 :: [Int] -> Int
f36 ls = length [i | i <- ls, i > 0]
-- Scriet,i o funct,ie care data fiind o list  ̆ a de numere calculeaz  ̆ a lista pozi  ̆ t,iilor elementelor imparedin lista originala.
f37 :: [Int] -> [Int]
f37 ls = [j | (i, j) <- zip ls [0..], odd i]
-- Scriet,i o funct,ie care calculeaza produsul tuturor cifrelor care apar în sirul de caractere dat caintrare. Daca nu sunt cifre în sir, raspunsul functiei trebuie sa fie  ̆1
f38 :: String -> Int
f38 [] = 1
f38 (x:xs) = if '0' <= x && x <= '9' then digitToInt x * f38 xs else f38 xs
-- digitToInt si isDigit sunt din Data.Char
f38' :: String -> Int
f38' ls = product [digitToInt i | i <- ls, isDigit i]


-- lab 4
-- întoarce lista divizorilor pozitivi ai lui
f41 :: Int -> [Int]
f41 x = [i | i <- [1..abs x], x `mod` i == 0]
--care întoarce True dacăs,i numai dacă n este număr prim.
f42 :: Int -> Bool
f42 x = length (f41 x) == 2
-- întoarce lista numerelor prime din intervalul [2..n].
f43 :: Int -> [Int]
f43 n = [i | i <- [2..n], f42 i]

-- se comportă asemenea lui zip dar are trei argumente:
f44 :: [a] -> [b] -> [c] -> [(a, b, c)]
f44 [] _ _ = []
f44 _ [] _ = []
f44 _ _ [] = []
f44 (x:xs) (y:ys) (z:zs) = (x, y, z) : f44 xs ys zs

-- verifică dacă o listă de valori Int este ordonată, relat,ia de ordine fiind cea naturală:
-- Folosind metoda prin selectie, funct,ia and si funct,ia zip
f45 :: [Int] -> Bool
f45 [] = True
f45 [_] = True
f45 xs = and [i < j | (i, j) <- zip xs (tail xs)]
--ac. lucru doar ca recursiv
f46 :: [Int] -> Bool
f46 [] = True
f46 [_] = True
f46 (x:y:xs) = not (x >= y) && f46 xs

-- primes, te ca argumente o listă de elemente s,i o relat,ie binară pe elementelerespective. Funct,ia întoarce True dacă oricare două elemente consecutive suntîn relat,ie.
f47 :: [a] -> (a -> a -> Bool) -> Bool
f47 [] _ = False
f47 [_] _ = False
f47 ls op = or [op x y | (x, y) <- zip ls (tail ls)]

(*:*) :: Int -> Int -> Bool
(*:*) x y = x `mod` y == 0

-- Definiti un operator *<*, asociativ la dreapta, cu precedenta 6,
(*<*) :: (Int, Int) -> (Int, Int) -> Bool
(a, b) *<* (c, d) = a >= c && b >= d
infixl 6 *<*        --ii dai precedenta operatorului si daca e infix sau nu. in forma infixata are asociativitate la dreapta

--primes, te ca argumente o funct,ie s,i o listă de funct,ii s,i întoarce listafunct,iilor obt,inute prin compunerea primului argument cu fiecare funct,ie dinal doilea argument.
f48 :: (b -> c) -> [a -> b] -> [a -> c]
f48 t1 t2 = [t1.y | y <- t2]

--primes, te un argument de tip a si o listă de funct,ii de tip a -> b s,i întoarcelista rezultatelor obt,inute prin aplicarea funct,iilor din listă pe primul argument:
f49 :: a -> [a -> b] -> [b]
f49 x ls = [t x | t <- ls]


-- lab 5
-- are ca argument o listă de perechide tip (a,b) s,i întoarce lista primelor elementelor din fiecare pereche:
f51 :: [(a, b)] -> [a]
f51 = map fst

-- listă de liste de valori Int s,i întoarce lista sumelor elementelor din fiecare listă
f52 :: [[Int]] -> [Int]
f52 = map sum

-- o listă de Int si întoarce o listăîn care elementele pare sunt înjumătăt,ite, iar cele impare sunt dublate:
f53 :: [Int] -> [Int]
f53 = map (\x -> if even x then x `div` 2 else x * 2)

-- functie care primes, te ca argument un caracter s,i o listă de s,iruri,rezultatul fiind lista s,irurilor care cont,in caracterul respectiv
f54 :: Char -> [[Char]] -> [[Char]]
f54 c = filter (\s -> c `elem` s)
-- primes, te ca argument o listă de întregi si întoarcelista pătratelor numerelor impare.
f55 :: [Int] -> [Int]
f55 ls = map (^2) (filter odd ls)
-- o listă de întregi si întoarcelista pătratelor numerelor din pozit,ii impare.
f56 :: [Int] -> [Int]
f56 ls = map ((^2) . fst) (filter (\(x, y) -> odd y) (zip ls [0..]))
-- o listă de siruri de caracteres,i întoarce lista obt,inută prin eliminarea consoanelor din fiecare s,ir.
f57 :: [[Char]] -> [[Char]]
f57 = map (filter (`elem` "aeiouAEIOU"))
-- functiile mymap s,i myfilter cu aceeas,i funct,ionalitate ca s,ifunct,iile predefinite.
f58 :: (a -> b) -> [a] -> [b]
f58 f ls = foldr (\x acc -> f x : acc) [] ls
f58' :: (a -> Bool) -> [a] -> [a]
f58' _ [] = []
f58' rel (x : xs)
    | rel x = x : f58' rel xs
    | otherwise = f58' rel xs
-- suma pătratelor elementelor impare dintr-o listă dată ca parametru.
f59 :: [Int] -> Int
f59 ls = sum (map (^2) (filter odd ls))
-- o funct,ie care verifică faptul că toate elementele dintr-o listă suntTrue, folosind foldr.
f510 :: [Bool] -> Bool
f510 = foldr (&&) True
-- Scriet,i o funct,ie care elimină un caracter din sir de caractere.
f511 :: Char -> String -> String
f511 c = filter (/= c)
-- elimină toate caracterele din al doilea argument care se găsesc în primul argument,
f512 :: String -> String -> String
f512 "" ys = ys
f512 (x:xs) ys = f512 xs (f511 x ys)
-- foloses, te foldr în locul recursiei
f512' :: String -> String -> String
f512' xs = foldr (\x acc -> if x `elem` xs then acc else x : acc) ""



-- lab 7
data Fruct
    = Mar String Bool
    | Portocala String Int

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False,
                Portocala "Sanguinello" 10,
                Portocala "Valencia" 22,
                Mar "Golden Delicious" True,
                Portocala "Sanguinello" 15,
                Portocala "Moro" 12,
                Portocala "Tarocco" 3,
                Portocala "Moro" 12,
                Portocala "Valencia" 2,
                Mar "Golden Delicious" False,
                Mar "Golden" False,
                Mar "Golden" True]

-- indică dacă un fruct este o portocală de Sicilia sau nu. Soiurile de portocale din Sicilia sunt Tarocco, Moro s,i Sanguinello.
f71 :: Fruct -> Bool
f71 (Portocala st _) = st `elem` ["Tarocco", "Moro", "Sanguinello"]
f71 (Mar _ _) = False

-- calculează numărul total de felii ale portocalelor de Sicilia dintr-o listă de fructe.
f72 :: [Fruct] -> Int
f72 ls = sum $ map (\(Portocala _ k) -> k) $ filter f71 ls


-- calcuelază numărul de mere care au viermi dintr-o lista de fructe.
f73help :: Fruct -> Bool
f73help (Portocala _ _) = False
f73help (Mar _ b) = b

f73 :: [Fruct] -> Int
f73 ls = length $ filter f73help ls



type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show


-- întoarce "Meow!" pentru pisică si "Woof!" pentru câine.
f74 :: Animal -> String
f74 (Pisica _) = "Meow!"
f74 (Caine _ _) = "Woof!"

-- întoarce rasa unui câine dat ca parametru sau Nothing dacă parametrul este o pisică.
f75 :: Animal -> Maybe String
f75 (Pisica _ ) = Nothing 
f75 (Caine _ r) = Just r


data Linie = L [Int]
    deriving Show
data Matrice = M [Linie]
    deriving Show

-- verifica daca suma elementelor de pe fiecare linie este egala cu o valoare n. Rezolvati cerinta folosind foldr.
f76help :: Linie -> Int -> Bool
f76help (L xs) n = (foldr (+) 0 xs) == n

f76 :: Matrice -> Int -> Bool
f76 (M lines) n = foldr (\li acc -> if (f76help li n) == False then False else acc) True lines

-- are ca parametru un element de tip Matrice si un numar intreg n, si care verifica daca toate liniile de lungime n din matrice au numai elemente strict pozitive.
f77help :: Int -> Linie -> Bool
f77help n (L xs) = if length xs /= n then False else if length (filter (<=0) xs) > 0 then True else False

f77 :: Matrice -> Int -> Bool
f77 (M ms) n = if length (filter (f77help n) ms) > 0 then False else True


-- verifică dacă toate liniile dintr-o matrice au aceeasi lungime.
f78helper :: Linie -> Int
f78helper (L ls) = length ls

f78 :: Matrice -> Bool
f78 (M ms) = foldr (\(L ls) acc -> if length ls /= (f78helper (ms !! 0)) then False else acc) True ms