import Data.Char
-- f :: Int -> Int
-- f x = x * 3

-- data MyData a b = MyData a b b
-- f :: (Eq a, Eq b) => MyData a b -> MyData a b -> Bool
-- f (MyData x1 y1 z1) (MyData x2 y2 z2 ) = x1 == x2 && y1 == y2 && z1 == z2


-- instance Functor (MyData a) where
--     fmap f (MyData x y z) = MyData  x (f y) (f z) 

-- data MyData a b = Data1 a | Data2 b
-- instance Functor (MyData a) where
--     fmap f (Data1 x) = Data1 x
--     fmap f (Data2 x) = Data2 (f x)


-- newtype MyBool = MyBool Bool
--     deriving (Eq, Show)

-- instance Semigroup MyBool where
--     MyBool x <> MyBool y = MyBool ( x || y )
-- instance Monoid MyBool where
--     mempty = MyBool True

-- newtype MyInt = MyInt Int
--     deriving (Eq, Show)
-- instance Semigroup MyInt where
--     MyInt x <> MyInt y = MyInt ( x + y + 1)
-- instance Monoid MyInt where
--     mempty = MyInt (-1)

-- data MyData a b = MyData a b b
-- instance Foldable (MyData a) where
--     foldMap f (MyData x y z) = f y <> f z

-- foldl (+) 0 (MyData 3 2 2)

-- data MyData a b = Data1 a | Data2 b
-- instance Foldable (MyData a) where
--     foldMap f (Data1 x) = mempty
--     foldMap f (Data2 x) = f x


-- data Wrap f a = Wrap (f a) deriving (Eq, Show)
-- instance Functor f => Functor (Wrap f) where
--     fmap f (Wrap fa) = Wrap (fmap f fa)


--Sa se scrie o functie care pentru o lista de siruri de caractere determina lista formata transformand fiecare sir care contine doar litere si cifre astfel:
-- Literele mari se transforma in litere mici -- Literele mici se transforma in '#' -- Cifrele se transforma in ‘*’
-- Pentru punctaj maxim scrieti si prototipul functiei cerute.> f ["FirstEXAMPLE", "2ndexample", "3-rd", "and FOURTH one"] ["f####example","*#########"]
fhelp0 :: Char -> Char     -- functie de conversie conform cerintei
fhelp0 c
  | isAsciiUpper c = toLower c
  | isAsciiLower c = '#'
  | otherwise = '*'

fhelp1 :: [Char] -> [Char]      -- functie care aplica conversia pe un string intreg. va fi folosita doar in f, si acolo stim siguri ca nu va fi pasat "" (ptc. il filtram).  
fhelp1 [c] = [fhelp0 c]         -- asa ca edge case-ul va fi doar sirul de lg. 1
fhelp1 (x:xs) = fhelp0 x : (fhelp1 xs)

fhelp2 :: [Char] -> Bool        -- functie care returneaza True daca sirul e alcatuit doar din ce se cere
fhelp2 [] = False
fhelp2 [c] = isAsciiLower c || isAsciiUpper c || (('0' <= c) && (c <= '9'))
fhelp2 (x:xs) = if not (isAsciiLower x || isAsciiUpper x || (('0' <= x) && (x <= '9'))) then False else fhelp2 xs


f :: [[Char]] -> [[Char]]
f ls = map fhelp1 (filter fhelp2 ls)



-- Sa se scrie o functie care primeste ca parametru o lista de liste de numere intregi si un numar n intreg si verifica daca liniile care au toate elementele 
-- mai mari decat n sunt de lungime para. f [[1,2,3],[11,6,8,8],[2,3,4,5,6,7,8],[6,6,7,8,8,9]] 4 = True .Pentru punctaj maxim scrieti si prototipul functiei cerute.

-- functie care spune daca toate elementele unui sir sunt peste un n dat
toatePeste :: Int -> [Int] -> Bool
toatePeste n [x] = x >= n       -- in aceasta functie vor fi pasate doar liste nevide, deci asta e sg. edge case
toatePeste n (x:xs) = if x < n then False else toatePeste n xs


-- functie de filtrare: returneaza True pt o lista de lg impara cu toate elem. peste n
f2help :: Int -> [Int] -> Bool
f2help _ [] = False
f2help n ls = if even (length ls) then False else toatePeste n ls


-- pastram in lista toate listele de lungime impara care au toate elem. mai mari decat n
-- daca avem cel putin o astfel de lista in lista mare ramasa, atunci ipoteza e falsa
f2 :: [[Int]] -> Int -> Bool
f2 ls n = if length (filter (f2help n) ls) > 0 then False else True



data ConstAB a b =
    ConstAB b
    deriving (Eq,Show)

instance Foldable (ConstAB a) where
    foldMap f (ConstAB b) = f b



data Arbore a = Nod a [(Char, Arbore a)] | Frunza a
arb , arb', arb'' :: Arbore Int
arb = Nod 40 [('a', Nod 20 [('a',Frunza 1), ('b',Frunza 2)]), ('b', Nod 30 [('z',Frunza 3), ('c',Frunza 4)])]
arb' =  Nod 40 [('a', Nod 20 [('a',Nod 1 []), ('b',Frunza 2)]), ('b', Nod 30 [('d',Frunza 3), ('c',Frunza 4)])]
arb'' =  Nod 40 [('a', Nod 20 [('a',Nod 1 []), ('b',Frunza 2)]), ('b', Nod 30 [('d',Frunza 3), ('f',Frunza 4)])]

-- o functie care pentru un arbore cu valori de tip Int calculeaza suma totala a valorilor intregi din arbore. Exemplu: f arb = 100

-- Sa se instantieze clasa Eq pentru tipul Arbore astfel incat verificarea egalitatii sa se faca astfel:
-- Pentru frunze se compara valorile folosind instanta implicita pentru tipul valorilor Pentru elemente de tip Nod se vor compara valorile asociate si listele.
-- Iar in cazul listelor nu se va tine cont de valorile caracterelor.-       Pentru componente cu constructori diferiti rezultatul va fi False.

-- a)
-- daca avem un nod, atunci ii returnam valoarea adunata cu sumele din subarborii sai
f3 :: Arbore Int -> Int
f3 (Frunza x) = x      -- facem pattern match pt frunze
f3 (Nod x ls) = x + sum (map (\(c, newNode) -> f3 newNode) ls)


-- b)
instance Eq a => Eq (Arbore a) where    -- trb ca tipul datelor sa fie din Eq sa le comparam
    Frunza x == Frunza y = x == y
    Nod x xs == Nod y ys = x == y && (map (snd) xs) == (map (snd) ys)   -- asa cum zice cerinta, pastram doar nodul, fara caracter
    Frunza _ == Nod _ _ = False
    Nod _ _ == Frunza _ = False


