module Test.RefIntegration where

import Prelude

import Effect (Effect, forE, foreachE, untilE, whileE)
import Effect.Console (log)
import Effect.Ref as Ref
import Test.Assert (assert)

main :: Effect Unit
main = do
  log "Testing forE"
  ref <- Ref.new 0
  forE 0 5 \i -> do
    Ref.modify_ (_ + i) ref
  val <- Ref.read ref
  -- 0 + 1 + 2 + 3 + 4 = 10
  assert (val == 10)

  log "Testing foreachE"
  ref2 <- Ref.new 0
  foreachE [10, 20, 30] \i -> do
    Ref.modify_ (_ + i) ref2
  val2 <- Ref.read ref2
  assert (val2 == 60)

  log "Testing whileE"
  ref3 <- Ref.new 0
  whileE (do
    v <- Ref.read ref3
    pure (v < 5)
  ) (do
    Ref.modify_ (_ + 1) ref3
  )
  val3 <- Ref.read ref3
  assert (val3 == 5)

  log "Testing untilE"
  ref4 <- Ref.new 0
  untilE do
    Ref.modify_ (_ + 1) ref4
    v <- Ref.read ref4
    pure (v >= 5)
  val4 <- Ref.read ref4
  assert (val4 == 5)

  log "All tests passed"
