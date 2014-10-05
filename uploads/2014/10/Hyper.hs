module Hyper where

data Nat =
    Zero
  | Succ Nat
  deriving (Eq, Ord)

infixr 6 .+
(.+) :: Nat -> Nat -> Nat
n .+ Zero       = n
n .+ (Succ n')  = Succ $ n .+ n'

infixr 7 .*
(.*) :: Nat -> Nat -> Nat
_ .* Zero       = Zero
n .* (Succ n')  = (n .+) $ n .* n'

infixr 8 .^
(.^) :: Nat -> Nat -> Nat
_ .^ Zero       = Succ Zero
n .^ (Succ n')  = (n .*) $ n .^ n'

-- generalize
hyper :: Nat -> Nat -> Nat -> Nat
hyper Zero _ b                  = Succ b
hyper (Succ Zero) a Zero        = a
hyper (Succ (Succ Zero)) _ Zero = Zero
hyper (Succ _) _ Zero           = Succ Zero
hyper (Succ n) a (Succ b)       = hyper n a $ hyper (Succ n) a b

-- plumbing
fromNum :: (Num a, Eq a, Ord a) => a -> Nat
fromNum n
  | n < 0     = error "Negative natural"
  | n == 0    = Zero
  | otherwise = Succ . fromNum $ n - 1

toNum :: Num a => Nat -> a
toNum Zero      = 0
toNum (Succ n)  = 1 + toNum n

-- can be shown on paper through induction
prop_preserve :: Nat -> Bool
prop_preserve n = n == (fromNum . toNum $ n)

instance Show Nat where
  show n = show $ toNum n

-- this is more efficient
hyperInt :: Integer -> Integer -> Integer -> Integer
hyperInt 0 _ b = b + 1
hyperInt 1 a b = a + b
hyperInt 2 a b = a * b
hyperInt _ _ 0 = 1
hyperInt n a b = hyperInt (n - 1) a $ hyperInt n a (b - 1)

