module NList
  ( NList
  , consElem
  , consList
  , emptyNList
  , headNList
  , tailNList
  ) where

data NList a =
    Elem a
  | List [NList a]
  deriving (Show, Eq)

-- keeping this for reference
data NList0 a = List' [NList0 a] deriving Show

test_list :: NList Integer
test_list = List [Elem 2, List [Elem 2, Elem 3], Elem 4]

emptyNList :: NList a
emptyNList = List []

consElem :: a -> NList a -> NList a
consElem x xs = consList (Elem x) xs

consList :: NList a -> NList a -> NList a
consList x (List xs) = List $ x : xs

headNList :: NList a -> NList a
headNList (List (x : _)) = x

tailNList :: NList a -> NList a
tailNList (List (_ : xs)) = List xs
