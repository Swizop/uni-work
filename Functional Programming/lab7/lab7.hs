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

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala tip _) = elem tip ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False 

test_ePortocalaDeSicilia1 =
    ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 =
    ePortocalaDeSicilia (Mar "Ionatan" True) == False

nrFeliiFrct (Portocala tip nr) = if ePortocalaDeSicilia (Portocala tip nr) then nr else 0
nrFeliiFrct (Mar _ _) = 0
nrFeliiSicilia :: [Fruct] -> Int
-- nrFeliiSicilia ls = foldr (+) 0 map(\(Portocala tip i) -> i)(filter ePortocalaDeSicilia ls)
nrFeliiSicilia = sum . map nrFeliiFrct

test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

nrMereViermi :: [Fruct] -> Int
nrMereViermi ls = sum [1 | (Mar _ are) <- ls, are]

test_nrMereViermi = nrMereViermi listaFructe == 2

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show

vorbeste :: Animal -> String
vorbeste (Caine _ _ ) = "Woof!"
vorbeste (Pisica _) = "Meow!"

rasa :: Animal -> Maybe String
rasa (Pisica _) = Nothing
rasa (Caine _ rasa) = Just rasa

data Linie = L [Int]
   deriving Show
data Matrice = M [Linie]
   deriving Show

verifica :: Matrice -> Int -> Bool
-- verifica (M list) n = foldr ((&&) . (\(L l) -> sum l == n) True list
verifica (M list) n = foldr (&&) True (map(\(L l) -> sum l == n) list)
test_verif1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10 == False
test_verif2 = verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25 == True
doarPozN :: Matrice -> Int -> Bool
doarPozN (M matrice) nr = foldr (\(L linie) acc -> (if lungimeN linie then allPoz linie else True) && acc) True matrice
    where lungimeN ls = length ls == nr
          allPoz ls = length ls == length (filter (>0) ls)

testPoz1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == True

testPoz2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == False
corect :: Matrice -> Bool
corect (M []) = True
corect (M [l]) = True
corect (M (L l1 : (L l2) : list)) = length l1 == length l2 && corect (M (L l2 : list))


testcorect1 = corect (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) == False
testcorect2 = corect (M[L[1,2,3], L[4,5,8], L[3,6,8], L[8,5,3]]) == True
