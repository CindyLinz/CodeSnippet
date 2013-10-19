{-# LANGUAGE ExistentialQuantification #-}
module Main where

data Printing = Endl | forall a. Show a => Printing a Printing

instance Show Printing where
  show Endl = "Endl"
  show (Printing a remain) = show a ++ " " ++ show remain

(<$>) :: Show a => a -> Printing -> Printing
(<$>) a remain = Printing a remain
infixr 8 <$>

prt :: Printing -> IO ()
prt Endl = putStrLn ""
prt (Printing a remain) = putStr (show a ++ " ") >> prt remain

main = do
  prt $ 3 <$> 4 <$> 'a' <$> Endl
  prt $ Endl
  prt $ "123" <$> Endl
