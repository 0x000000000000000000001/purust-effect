module Test.AdapterProbe where

import Effect (Effect)
import Data.Unit (Unit)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, EffectFn4, EffectFn5, EffectFn6, EffectFn7, EffectFn8, EffectFn9, EffectFn10)

foreign import opaque :: forall a. a -> a
foreign import evaluate :: forall a. (Unit -> a) -> Effect a
foreign import invokeEffectFn1 :: forall r. EffectFn1 Int r -> Int -> Effect r
foreign import invokeEffectFn2 :: forall r. EffectFn2 Int Int r -> Int -> Int -> Effect r
foreign import invokeEffectFn3 :: forall r. EffectFn3 Int Int Int r -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn4 :: forall r. EffectFn4 Int Int Int Int r -> Int -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn5 :: forall r. EffectFn5 Int Int Int Int Int r -> Int -> Int -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn6 :: forall r. EffectFn6 Int Int Int Int Int Int r -> Int -> Int -> Int -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn7 :: forall r. EffectFn7 Int Int Int Int Int Int Int r -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn8 :: forall r. EffectFn8 Int Int Int Int Int Int Int Int r -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn9 :: forall r. EffectFn9 Int Int Int Int Int Int Int Int Int r -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Effect r
foreign import invokeEffectFn10 :: forall r. EffectFn10 Int Int Int Int Int Int Int Int Int Int r -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Effect r
