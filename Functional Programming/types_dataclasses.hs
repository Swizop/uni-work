import Data.Monoid
import qualified Data.Foldable as F
-- VERSION WITHOUT POINT

-- data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)  
-- surface :: Shape -> Float  
-- surface (Circle _ _ r) = pi * r ^ 2  
-- surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)  

-- call function : surface $ Circle 10 20 10
-- constructors are functions, so we can map them and partially apply them and everything
-- map (Circle 10 20) [4,5,6,6]  => [Circle 10 20 4, Circle 10 20 5 ..]

data Point = Point Float Float deriving (Show)  
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)  

surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)  

-- how to call: surface (Rectangle (Point 0 0) (Point 100 100))  

nudge :: Shape -> Float -> Float -> Shape  
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r  
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))  


-- RECORD SYNTAX (dam un nume la variabilele din clasa, ca in C++)
data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show, Eq)   

-- By using record syntax to create this data type, Haskell automatically made these functions: firstName, lastName, age, height, phoneNumber and flavor.
-- ghci> :t flavor  
-- flavor :: Person -> String  

-- ghci> let adRock = Person {firstName = "Adam", lastName = "Horovitz", age = 41}  (trb sa scoatem height,phonenumber etc din linia 29 ca sa mearga asta)
-- ghci> let mca = Person {firstName = "Adam", lastName = "Yauch", age = 44}  
-- ghci> mca == adRock  
-- False  
-- ghci> mikeD == adRock  
-- False  


data Car = Car {company :: String, model :: String, year :: Int} deriving (Show) 
-- you can make a new car like this: Car {company="Ford", model="Mustang", year=1967}   (you don't have to write them in their specific order)

tellCar :: Car -> String  
tellCar (Car {company = c, model = m, year = y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y  


data Vector a = Vector a a a deriving (Show)  
  
vplus :: (Num t) => Vector t -> Vector t -> Vector t  
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)  


-- Typeclasses are more like interfaces. We don't make data from typeclasses. Instead, we first make our data type and then we think about what it can act like.
-- If it can act like something that can be equated, we make it an instance of the Eq typeclass. If it can act like something that can be ordered, 
-- we make it an instance of the Ord typeclass.


data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday   
           deriving (Eq, Ord, Show, Read, Bounded, Enum)  

-- Because all the value constructors are nullary (take no parameters, i.e. fields), we can make it part of the Enum typeclass. 
-- The Enum typeclass is for things that have predecessors and successors. We can also make it part of the Bounded typeclass, which is for things that have a lowest possible value and highest possible value. 


-- type : gives types different names
-- type String = [Char]  
-- Type synonyms can also be parameterized. If we want a type that represents an association list type but still want it to be general so it can use any type as the keys and values,
-- we can do this:
-- type AssocList k v = [(k,v)] 

-- Just like we can partially apply functions to get new functions, we can partially apply type parameters and get new type constructors from them.



-- A CLASS CAN POINT TO ITSELF! example (remaking the list class):

-- data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)  
-- data List a = Empty | Cons { listHead :: a, listTail :: List a} deriving (Show, Read, Eq, Ord)  

-- poti apela si infix constructorul (e la fel ca : de la liste)
-- ghci> Empty  
-- Empty  
-- ghci> 5 `Cons` Empty  
-- Cons 5 Empty  
-- ghci> 4 `Cons` (5 `Cons` Empty)  
-- Cons 4 (Cons 5 Empty)  


-- constructor facut doar din caractere speciale => default infix
-- infixr 5 :-:  
-- data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)  

-- ghci> 3 :-: 4 :-: 5 :-: Empty  
-- (:-:) 3 ((:-:) 4 ((:-:) 5 Empty))  

-- functie prin care lipim 2 liste facute de noi
-- infixr 5  .++  
-- (.++) :: List a -> List a -> List a   
-- Empty .++ ys = ys  
-- (x :-: xs) .++ ys = x :-: (xs .++ ys)  

-- Notice how we pattern matched on (x :-: xs). That works because pattern matching is actually about matching constructors. We can match on :-: 
-- because it is a constructor for our own list type and we can also match on : because it is a constructor for the built-in list type. Same goes for []


-- BST implement
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  

-- add operation
singleton :: a -> Tree a  
singleton x = Node x EmptyTree EmptyTree  

treeInsert :: (Ord a) => a -> Tree a -> Tree a  
treeInsert x EmptyTree = singleton x  
treeInsert x (Node a left right)   
    | x == a = Node x left right  
    | x < a  = Node a (treeInsert x left) right  
    | x > a  = Node a left (treeInsert x right) 

-- find
treeElem :: (Ord a) => a -> Tree a -> Bool  
treeElem x EmptyTree = False  
treeElem x (Node a left right)  
    | x == a = True  
    | x < a  = treeElem x left  
    | x > a  = treeElem x right  



-- FUNCTORI
-- class Functor f where  
--     fmap :: (a -> b) -> f a -> f b  

-- cand declaram o instanta a clasei functor, trebuie sa implementam functia fmap
-- instance Functor [] where  
--     fmap = map  
-- That's it! Notice how we didn't write instance Functor [a] where, because from fmap :: (a -> b) -> f a -> f b, 
--we see that the f has to be a type constructor that takes one type. [a] is already a concrete type (of a list with any type inside it), 
--while [] is a type constructor that takes one type and can produce types such as [Int], [String] or even [[String]]


-- apel : ghci> fmap (*2) [1..3]  
-- [2,4,6]  

-- Types that can act like a box can be functors. 

-- instance Functor Maybe where  
--     fmap f (Just x) = Just (f x)  
--     fmap f Nothing = Nothing  
-- Again, notice how we wrote instance Functor Maybe where instead of instance Functor (Maybe m) where


    -- apel:
--     fmap (*2) (Just 200)  
-- Just 400  
-- ghci> fmap (*2) Nothing  
-- Nothing  


-- instance Functor Tree where  
--     fmap f EmptyTree = EmptyTree  
--     fmap f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub) 

-- apel:
-- fmap (*2) EmptyTree  
-- EmptyTree  
-- ghci> fmap (*4) (foldr treeInsert EmptyTree [5,7,3,2,1,7])  









-- MONOIZI: cand ai o operatie care are un element neutru, primeste 2 chestii si returneaza doar una, si daca ai mai multe inlantuite nu conteaza ordinea
--ex. de chestii care extind monoid: ++, : , *
-- the binary function has to be associative

-- PENTRU CLASA MONOID TRB SA INCLUDEM import Data.Monoid
-- class Monoid m where  
--     mempty :: m  
--     mappend :: m -> m -> m  
--     mconcat :: [m] -> m  
--     mconcat = foldr mappend mempty  


-- mempty -> element neutru for a particular monoid. not really a function
-- mappend being a binary function that takes two monoid values and returns a third. (de ex, *, sau ++)
-- mappend e pt cand ai mai multe d alea inlantuite gen 3 * 3 * 4

-- When making a type an instance of Monoid, it suffices to just implement mempty and mappend. The reason mconcat is there at all is because for some instances, 
-- there might be a more efficient way to implement mconcat, but for most instances the default implementation is just fine.


-- when making instances, we have to make sure they follow these laws:

-- mempty `mappend` x = x
-- x `mappend` mempty = x
-- (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)



-- Lists are monoids
-- Yes, lists are monoids! Like we've seen, the ++ function and the empty list [] form a monoid. The instance is very simple:

-- instance Monoid [a] where  
--     mempty = []  
--     mappend = (++)  

-- Lists are an instance of the Monoid type class regardless of the type of the elements they hold. Notice that we wrote instance Monoid [a] and not instance Monoid [],
--  because Monoid requires a concrete type for an instance.

-- ghci> [1,2,3] `mappend` [4,5,6]  
-- [1,2,3,4,5,6]  
-- ghci> ("one" `mappend` "two") `mappend` "tree"  
-- "onetwotree"  
-- ghci> "one" `mappend` ("two" `mappend` "tree")  
-- "onetwotree"  
-- ghci> "one" `mappend` "two" `mappend` "tree"  
-- "onetwotree"  
-- ghci> "pang" `mappend` mempty  
-- "pang"  
-- ghci> mconcat [[1,2],[3,6],[9]]  
-- [1,2,3,6,9]  
-- ghci> mempty :: [a]  
-- []  

-- Notice that in the last line, we had to write an explicit type annotation, because if we just did mempty, GHCi wouldn't know which instance to use, so we had to say we want the list instance. 




-- FOLDABLE
-- import qualified Data.Foldable as F
-- suprascriem functia foldr

-- instance F.Foldable Tree where  
--     foldMap f Empty = mempty  
--     foldMap f (Node x l r) = F.foldMap f l `mappend`  
--                              f x           `mappend`  
--                              F.foldMap f r  


-- tests:
-- ghci> F.foldl (+) 0 testTree  
-- 42  
-- ghci> F.foldl (*) 1 testTree  
-- 64800  