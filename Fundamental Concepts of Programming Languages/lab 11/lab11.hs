import Data.List
import Data.Maybe

type Name = String 

data Value = VBool Bool 
    | VInt Int 
    | VFun (Value -> Value)
    | VError 

data Hask = HTrue -- 
    | HFalse --
    | HIf Hask Hask Hask --
    | HLet Name Hask Hask --
    | HLit Int --
    | Hask :==: Hask -- 
    | Hask :+: Hask --
    | Hask :*: Hask 
    | HVar Name --
    | HLam Name Hask --
    | Hask :$: Hask 
    deriving Show
-- let x = y + 1 in z = 2 * x 

infix 4 :==:
infixl 6 :+:
infixl 7 :*: 
infixl 9 :$:

type HEnv = [(Name, Value)]
-- env = [("x", VInt 10), ("y", VBool False)]

showV :: Value -> String 
showV (VBool b) = show b 
showV (VInt i) = show i 
showV (VFun _) = "<function>"
showV VError = "<error>"

instance Show Value where 
    show = showV 

eqV :: Value -> Value -> Bool 
eqV (VBool b1) (VBool b2) = b1 == b2 
eqV (VInt i1) (VInt i2) = i1 == i2 
eqV _ _ = False 

instance Eq Value where 
    (==) = eqV 

hEval :: Hask -> HEnv -> Value
hEval HTrue _ = VBool True
hEval HFalse _ = VBool False 
hEval (HIf cond sttrue stfalse) env = hif (hEval cond env) (hEval sttrue env) (hEval stfalse env)
    where 
        hif (VBool b) st1 st2 = if b then st1 else st2 
        hif _ _ _ = VError 
hEval (exp1 :+: exp2) env = hadd (hEval exp1 env) (hEval exp2 env)
    where 
        hadd (VInt i1) (VInt i2) = VInt $ i1 + i2
        hadd _ _ = VError 
hEval (HLit i) _ = VInt i 
hEval (HVar x) env = fromMaybe VError $ lookup x env
hEval (HLet x valexpr expr) env = hEval expr ((x, hEval valexpr env) : env)
hEval (exp1 :==: exp2) env = VBool $ (hEval exp1 env) == (hEval exp2 env)
hEval (HLam x expr) env = VFun (\v -> hEval expr ((x, v) : env))
hEval (f :$: g) env = happ (hEval f env) (hEval g env) 
    where 
        happ (VFun f) v = f v 
        happ _ _ = VError 
hEval (exp1 :*: exp2) env = hmul (hEval exp1 env) (hEval exp2 env)
    where 

-- \x -> expr 

-- [("var", VInt 27), ("isActive", VBool False)]
-- hEval "var" env = VInt 27 
-- hEval "isActive" env = VBool False 
-- hEval "altceva" env = VError 

-- let x = y + 1 in 2 * x 
run :: Hask -> String 
run pg = showV $ hEval pg []

h0 = (HLam "x" (HLam "y" ((HVar "x") :+: (HVar "y")))) :$: (HLit 3) :$: (HLit 4)

-- incercati run h0 

h1 = HLet "x" (HLit 3) ((HLit 4) :*: HVar "x") 

-- incercati run h1 

--  adaugati semantica pentru :*: 