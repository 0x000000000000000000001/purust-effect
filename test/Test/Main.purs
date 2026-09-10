module Test.Main where

import Prelude

import Effect (Effect, forE)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console (log)
import Test.Assert (assertEqual)
import Test.Adapters as Adapters
import Test.Loops as Loops
import Test.Probe (checkReplay, fail, mark, scenario)
import Test.RefIntegration as RefIntegration

lifted :: forall m. MonadEffect m => Int -> m Int
lifted n = do
  value <- liftEffect (mark n)
  pure (value + 1)

main :: Effect Unit
main = case scenario of
  0 -> do
    checkReplay "pure values, functions and nested effects" [7] \_ -> do
      value <- pure 42
      assertEqual { actual: value, expected: 42 }
      record <- pure { label: "value", count: 3 }
      assertEqual { actual: record.label, expected: "value" }
      assertEqual { actual: record.count, expected: 3 }
      function <- pure (\n -> n + 1)
      assertEqual { actual: function 41, expected: 42 }
      nested <- pure (mark 7)
      result <- nested
      assertEqual { actual: result, expected: 7 }
    checkReplay "bind result and continuation order" [1, 3] \_ -> do
      value <- mark 1
      result <- mark (value + 2)
      assertEqual { actual: result, expected: 3 }
    checkReplay "map and apply order" [1, 2] \_ -> do
      value <- (\n x -> n * 10 + x) <$> mark 1 <*> mark 2
      assertEqual { actual: value, expected: 12 }
    checkReplay "discard operators preserve order and result" [1, 2, 3, 4] \_ -> do
      right <- mark 1 *> mark 2
      left <- mark 3 <* mark 4
      assertEqual { actual: right, expected: 2 }
      assertEqual { actual: left, expected: 3 }
    checkReplay "Effect Semigroup and Monoid" [1, 2] \_ -> do
      value <- (show <$> mark 1) <> (show <$> mark 2)
      assertEqual { actual: value, expected: "12" }
      empty <- (mempty :: Effect String)
      assertEqual { actual: empty, expected: "" }
    checkReplay "polymorphic MonadEffect" [41] \_ -> do
      result <- lifted 41
      assertEqual { actual: result, expected: 42 }
    Loops.run
    RefIntegration.main
    Adapters.run
    log "Effect tests passed"
  1 -> do
    fail
    log "UNREACHABLE after failed bind"
  2 -> do
    _ <- mark 1
    fail
    log "UNREACHABLE after failed continuation"
  3 -> do
    forE 0 3 \i -> if i == 0 then fail else log "UNREACHABLE next loop iteration"
    log "UNREACHABLE after failed loop"
  _ -> assertEqual { actual: scenario, expected: 0 }
