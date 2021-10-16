import Data.List

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x


triple x = x + x + x

--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y

-- maxim x y = if (x > y) then x else y           --format: shift alt f
                                                  --windows: ctrl shift


maxim3 x y z = maxim x (maxim y z)


max3' x y z =
     if (x > y)
          then if (x > z) then x else z
          else if (z > y) then z else y


max3 x y z = let
             u = maxim x y
             in (maxim  u z)

               
maxim4 x y z t = 
     let u = maxim x y 
     in let w = maxim z t 
          in maxim u w


testmaxim4 x y z t = 
     let max = maxim4 x y z t
     in max >= x && max >= y && max >= z && max >= t




-- TEMA

-- a) functie cu 2 parametri care calculeaza suma patratelor celor doua numere

a :: Integer -> Integer -> Integer
a x y = x * x + y * y


-- b) functie care returneaza daca e par sau impar

b :: Integer -> [Char]
b x = if(mod x 2 == 0) then "par" else "impar"


-- c) functie care calc factorialul unui nr

c :: Integer -> Integer
c x =
     if(x == 1)
          then 1
          else x * c (x - 1)


-- d) functie care verifica daca primul parametru e mai mare decat dublul celui de al doilea param.

d :: Integer -> Integer -> Bool
d x y = if(x > y * 2) then True else False