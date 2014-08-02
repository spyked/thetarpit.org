module NList
  ( NList
  , consElem
  , consList
  , emptyNList
  , headNList
  , tailNList
  ) where

data NList a =
    Empty
  | ConsElem a (NList a)
  | ConsList (NList a) (NList a)
  deriving (Show, Eq)

test_list :: NList Integer
test_list = ConsElem 2 $ ConsList (ConsElem 2 $ ConsElem 3 $ Empty)
  $ ConsElem 4 Empty

emptyNList :: NList a
emptyNList = Empty

consElem :: a -> NList a -> NList a
consElem = ConsElem

consList :: NList a -> NList a -> NList a
consList = ConsList

headNElem :: NList a -> a
headNElem (ConsElem x _) = x

headNList :: NList a -> NList a
headNList (ConsList x _) = x
-- contrived definition
-- e.g. (headNList $ ConsElem 2 Empty) == ConsElem 2 Empty
headNList (ConsElem x _) = ConsElem x Empty

tailNList :: NList a -> NList a
tailNList (ConsElem _ y) = y
tailNList (ConsList _ y) = y
