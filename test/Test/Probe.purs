module Test.Probe where

import Prelude

import Effect (Effect)

foreign import scenario :: Int
foreign import mark :: Int -> Effect Int
foreign import tick :: Effect Int
foreign import fail :: Effect Unit
foreign import checkReplay :: String -> Array Int -> (Unit -> Effect Unit) -> Effect Unit
