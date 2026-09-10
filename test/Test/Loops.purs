module Test.Loops (run) where

import Prelude

import Effect (Effect, forE, foreachE, untilE, whileE)
import Test.Probe (checkReplay, mark, tick)

run :: Effect Unit
run = do
  checkReplay "forE inclusive lower/exclusive upper, negative indices" [-2, -1, 0, 1, 2] \_ ->
    forE (-2) 3 \index -> void (mark index)

  checkReplay "forE equal bounds" [] \_ ->
    forE 4 4 \index -> void (mark index)

  checkReplay "forE inverted bounds" [] \_ ->
    forE 3 (-2) \index -> void (mark index)

  checkReplay "foreachE preserves element order" [3, 1, 4] \_ ->
    foreachE [3, 1, 4] \value -> void (mark value)

  checkReplay "foreachE empty array" [] \_ ->
    foreachE [] \value -> void (mark value)

  checkReplay "foreachE record elements" [7, 9] \_ ->
    foreachE [{ value: 7 }, { value: 9 }] \record -> void (mark record.value)

  checkReplay "whileE condition before each body, ignores body result" [1, 40, 2, 40, 3] \_ ->
    whileE
      (do
        count <- tick
        pure (count < 3)
      )
      (mark 40)

  checkReplay "whileE initially false" [1] \_ ->
    whileE
      (do
        _ <- tick
        pure false
      )
      (mark 999)

  checkReplay "untilE stops at first true condition" [1, 2, 3] \_ ->
    untilE do
      count <- tick
      pure (count >= 3)

  checkReplay "untilE initially true still evaluates condition once" [1] \_ ->
    untilE do
      _ <- tick
      pure true

  checkReplay "nested loops preserve outer and inner order" [3, 5, 13, 15] \_ ->
    forE 0 2 \index ->
      foreachE [3, 5] \value -> void (mark (index * 10 + value))
