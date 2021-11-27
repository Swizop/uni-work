myLast :: [a] -> a
myLast ls = last ls

myButLast :: [a] -> a
myButLast [] = error "less than 2 elements"
myButLast (x:xs)
    | length xs == 1 = x
    | otherwise = myButLast xs

elementAt :: [a] -> Int -> a
elementAt ls x = ls !! (x - 1)

myLength :: [a] -> Int
mytLength [] = 0
myLength [x] = 1
myLength (l:ls) = 1 + myLength ls

myReverse :: [a] -> [a]
myReverse [] = []
myReverse xs = last xs : myReverse (init xs)

isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = (xs == (reverse xs))
main = print(isPalindrome [True, False, True])
