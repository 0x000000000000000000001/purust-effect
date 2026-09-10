module Test.Adapters where

import Prelude

import Effect (Effect)
import Effect.Unsafe (unsafePerformEffect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, EffectFn4, EffectFn5, EffectFn6, EffectFn7, EffectFn8, EffectFn9, EffectFn10, mkEffectFn1, runEffectFn1, mkEffectFn2, runEffectFn2, mkEffectFn3, runEffectFn3, mkEffectFn4, runEffectFn4, mkEffectFn5, runEffectFn5, mkEffectFn6, runEffectFn6, mkEffectFn7, runEffectFn7, mkEffectFn8, runEffectFn8, mkEffectFn9, runEffectFn9, mkEffectFn10, runEffectFn10)
import Test.AdapterProbe (evaluate, opaque, invokeEffectFn1, invokeEffectFn2, invokeEffectFn3, invokeEffectFn4, invokeEffectFn5, invokeEffectFn6, invokeEffectFn7, invokeEffectFn8, invokeEffectFn9, invokeEffectFn10)
import Test.Assert (assertEqual)
import Test.Probe (checkReplay, mark, tick)

run :: Effect Unit
run = do
  checkReplay "EffectFn1 intrinsic and foreign adapters, native callbacks and replay" [701, 701, 701, 701] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn1 (\a -> mark (capture + a * 1)))
      foreignCallback = opaque mkEffectFn1 (\a -> mark (capture + a * 1))
      action = opaque runEffectFn1 foreignCallback 1
    in do
      actual <- runEffectFn1 intrinsic 1
      assertEqual { actual, expected: 701 }
      native <- invokeEffectFn1 intrinsic 1
      assertEqual { actual: native, expected: 701 }
      nativeForeign <- invokeEffectFn1 foreignCallback 1
      assertEqual { actual: nativeForeign, expected: 701 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 701 }
  checkReplay "EffectFn2 intrinsic and foreign adapters, native callbacks and replay" [705, 704, 705, 704] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn2 (\a b -> mark (capture + a * 1 + b * 2)))
      foreignCallback = opaque mkEffectFn2 (\a b -> mark (capture + a * 1 + b * 2))
      action = opaque runEffectFn2 foreignCallback 2 1
    in do
      actual <- runEffectFn2 intrinsic 1 2
      assertEqual { actual, expected: 705 }
      native <- invokeEffectFn2 intrinsic 2 1
      assertEqual { actual: native, expected: 704 }
      nativeForeign <- invokeEffectFn2 foreignCallback 1 2
      assertEqual { actual: nativeForeign, expected: 705 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 704 }
  checkReplay "EffectFn3 intrinsic and foreign adapters, native callbacks and replay" [714, 710, 714, 710] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn3 (\a b c -> mark (capture + a * 1 + b * 2 + c * 3)))
      foreignCallback = opaque mkEffectFn3 (\a b c -> mark (capture + a * 1 + b * 2 + c * 3))
      action = opaque runEffectFn3 foreignCallback 3 2 1
    in do
      actual <- runEffectFn3 intrinsic 1 2 3
      assertEqual { actual, expected: 714 }
      native <- invokeEffectFn3 intrinsic 3 2 1
      assertEqual { actual: native, expected: 710 }
      nativeForeign <- invokeEffectFn3 foreignCallback 1 2 3
      assertEqual { actual: nativeForeign, expected: 714 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 710 }
  checkReplay "EffectFn4 intrinsic and foreign adapters, native callbacks and replay" [730, 720, 730, 720] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn4 (\a b c d -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4)))
      foreignCallback = opaque mkEffectFn4 (\a b c d -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4))
      action = opaque runEffectFn4 foreignCallback 4 3 2 1
    in do
      actual <- runEffectFn4 intrinsic 1 2 3 4
      assertEqual { actual, expected: 730 }
      native <- invokeEffectFn4 intrinsic 4 3 2 1
      assertEqual { actual: native, expected: 720 }
      nativeForeign <- invokeEffectFn4 foreignCallback 1 2 3 4
      assertEqual { actual: nativeForeign, expected: 730 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 720 }
  checkReplay "EffectFn5 intrinsic and foreign adapters, native callbacks and replay" [755, 735, 755, 735] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn5 (\a b c d e -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5)))
      foreignCallback = opaque mkEffectFn5 (\a b c d e -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5))
      action = opaque runEffectFn5 foreignCallback 5 4 3 2 1
    in do
      actual <- runEffectFn5 intrinsic 1 2 3 4 5
      assertEqual { actual, expected: 755 }
      native <- invokeEffectFn5 intrinsic 5 4 3 2 1
      assertEqual { actual: native, expected: 735 }
      nativeForeign <- invokeEffectFn5 foreignCallback 1 2 3 4 5
      assertEqual { actual: nativeForeign, expected: 755 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 735 }
  checkReplay "EffectFn6 intrinsic and foreign adapters, native callbacks and replay" [791, 756, 791, 756] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn6 (\a b c d e f -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6)))
      foreignCallback = opaque mkEffectFn6 (\a b c d e f -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6))
      action = opaque runEffectFn6 foreignCallback 6 5 4 3 2 1
    in do
      actual <- runEffectFn6 intrinsic 1 2 3 4 5 6
      assertEqual { actual, expected: 791 }
      native <- invokeEffectFn6 intrinsic 6 5 4 3 2 1
      assertEqual { actual: native, expected: 756 }
      nativeForeign <- invokeEffectFn6 foreignCallback 1 2 3 4 5 6
      assertEqual { actual: nativeForeign, expected: 791 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 756 }
  checkReplay "EffectFn7 intrinsic and foreign adapters, native callbacks and replay" [840, 784, 840, 784] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn7 (\a b c d e f g -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7)))
      foreignCallback = opaque mkEffectFn7 (\a b c d e f g -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7))
      action = opaque runEffectFn7 foreignCallback 7 6 5 4 3 2 1
    in do
      actual <- runEffectFn7 intrinsic 1 2 3 4 5 6 7
      assertEqual { actual, expected: 840 }
      native <- invokeEffectFn7 intrinsic 7 6 5 4 3 2 1
      assertEqual { actual: native, expected: 784 }
      nativeForeign <- invokeEffectFn7 foreignCallback 1 2 3 4 5 6 7
      assertEqual { actual: nativeForeign, expected: 840 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 784 }
  checkReplay "EffectFn8 intrinsic and foreign adapters, native callbacks and replay" [904, 820, 904, 820] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn8 (\a b c d e f g h -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8)))
      foreignCallback = opaque mkEffectFn8 (\a b c d e f g h -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8))
      action = opaque runEffectFn8 foreignCallback 8 7 6 5 4 3 2 1
    in do
      actual <- runEffectFn8 intrinsic 1 2 3 4 5 6 7 8
      assertEqual { actual, expected: 904 }
      native <- invokeEffectFn8 intrinsic 8 7 6 5 4 3 2 1
      assertEqual { actual: native, expected: 820 }
      nativeForeign <- invokeEffectFn8 foreignCallback 1 2 3 4 5 6 7 8
      assertEqual { actual: nativeForeign, expected: 904 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 820 }
  checkReplay "EffectFn9 intrinsic and foreign adapters, native callbacks and replay" [985, 865, 985, 865] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn9 (\a b c d e f g h i -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8 + i * 9)))
      foreignCallback = opaque mkEffectFn9 (\a b c d e f g h i -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8 + i * 9))
      action = opaque runEffectFn9 foreignCallback 9 8 7 6 5 4 3 2 1
    in do
      actual <- runEffectFn9 intrinsic 1 2 3 4 5 6 7 8 9
      assertEqual { actual, expected: 985 }
      native <- invokeEffectFn9 intrinsic 9 8 7 6 5 4 3 2 1
      assertEqual { actual: native, expected: 865 }
      nativeForeign <- invokeEffectFn9 foreignCallback 1 2 3 4 5 6 7 8 9
      assertEqual { actual: nativeForeign, expected: 985 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 865 }
  checkReplay "EffectFn10 intrinsic and foreign adapters, native callbacks and replay" [1085, 920, 1085, 920] \_ ->
    let
      capture = opaque 700
      intrinsic = opaque (mkEffectFn10 (\a b c d e f g h i j -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8 + i * 9 + j * 10)))
      foreignCallback = opaque mkEffectFn10 (\a b c d e f g h i j -> mark (capture + a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8 + i * 9 + j * 10))
      action = opaque runEffectFn10 foreignCallback 10 9 8 7 6 5 4 3 2 1
    in do
      actual <- runEffectFn10 intrinsic 1 2 3 4 5 6 7 8 9 10
      assertEqual { actual, expected: 1085 }
      native <- invokeEffectFn10 intrinsic 10 9 8 7 6 5 4 3 2 1
      assertEqual { actual: native, expected: 920 }
      nativeForeign <- invokeEffectFn10 foreignCallback 1 2 3 4 5 6 7 8 9 10
      assertEqual { actual: nativeForeign, expected: 1085 }
      foreignResult <- action
      assertEqual { actual: foreignResult, expected: 920 }
  checkReplay "EffectFn record, function and nested Effect results" [1, 2, 3] \_ -> do
    let
      records = opaque (mkEffectFn2 (\label valid -> do
        _ <- mark 1
        pure { label, valid }))
      functions = opaque mkEffectFn1 (\a -> do
        _ <- mark 2
        pure (\b -> a + b))
      nested = opaque mkEffectFn1 (\a -> pure (mark a))
    record <- runEffectFn2 records "value" true
    assertEqual { actual: record.label, expected: "value" }
    assertEqual { actual: record.valid, expected: true }
    function <- runEffectFn1 functions 40
    assertEqual { actual: function 2, expected: 42 }
    action <- runEffectFn1 nested 3
    actual <- action
    assertEqual { actual, expected: 3 }
  checkReplay "unsafePerformEffect returns values and executes once per invocation" [1, 2] \_ -> do
    first <- evaluate (\_ -> unsafePerformEffect tick)
    second <- evaluate (\_ -> opaque unsafePerformEffect tick)
    assertEqual { actual: first, expected: 1 }
    assertEqual { actual: second, expected: 2 }
  checkReplay "unsafePerformEffect preserves function and nested Effect values" [7] \_ -> do
    let
      function = opaque unsafePerformEffect (pure (\a -> a + 1))
      action = opaque unsafePerformEffect (pure (mark 7))
    assertEqual { actual: function 41, expected: 42 }
    result <- action
    assertEqual { actual: result, expected: 7 }
  checkReplay "EffectFn1 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn1 (\a -> do
        _ <- mark 1
        pure ("L" <> show a)))
      right = opaque (mkEffectFn1 (\a -> do
        _ <- mark 2
        pure ("R" <> show a)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn1 Int String)
    actual <- runEffectFn1 combined 1
    assertEqual { actual, expected: "L1R1" }
    emptyResult <- runEffectFn1 empty 1
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn2 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn2 (\a b -> do
        _ <- mark 1
        pure ("L" <> show a <> show b)))
      right = opaque (mkEffectFn2 (\a b -> do
        _ <- mark 2
        pure ("R" <> show a <> show b)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn2 Int Int String)
    actual <- runEffectFn2 combined 1 2
    assertEqual { actual, expected: "L12R12" }
    emptyResult <- runEffectFn2 empty 1 2
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn3 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn3 (\a b c -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c)))
      right = opaque (mkEffectFn3 (\a b c -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn3 Int Int Int String)
    actual <- runEffectFn3 combined 1 2 3
    assertEqual { actual, expected: "L123R123" }
    emptyResult <- runEffectFn3 empty 1 2 3
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn4 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn4 (\a b c d -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d)))
      right = opaque (mkEffectFn4 (\a b c d -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn4 Int Int Int Int String)
    actual <- runEffectFn4 combined 1 2 3 4
    assertEqual { actual, expected: "L1234R1234" }
    emptyResult <- runEffectFn4 empty 1 2 3 4
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn5 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn5 (\a b c d e -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d <> show e)))
      right = opaque (mkEffectFn5 (\a b c d e -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d <> show e)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn5 Int Int Int Int Int String)
    actual <- runEffectFn5 combined 1 2 3 4 5
    assertEqual { actual, expected: "L12345R12345" }
    emptyResult <- runEffectFn5 empty 1 2 3 4 5
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn6 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn6 (\a b c d e f -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d <> show e <> show f)))
      right = opaque (mkEffectFn6 (\a b c d e f -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d <> show e <> show f)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn6 Int Int Int Int Int Int String)
    actual <- runEffectFn6 combined 1 2 3 4 5 6
    assertEqual { actual, expected: "L123456R123456" }
    emptyResult <- runEffectFn6 empty 1 2 3 4 5 6
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn7 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn7 (\a b c d e f g -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d <> show e <> show f <> show g)))
      right = opaque (mkEffectFn7 (\a b c d e f g -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d <> show e <> show f <> show g)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn7 Int Int Int Int Int Int Int String)
    actual <- runEffectFn7 combined 1 2 3 4 5 6 7
    assertEqual { actual, expected: "L1234567R1234567" }
    emptyResult <- runEffectFn7 empty 1 2 3 4 5 6 7
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn8 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn8 (\a b c d e f g h -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d <> show e <> show f <> show g <> show h)))
      right = opaque (mkEffectFn8 (\a b c d e f g h -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d <> show e <> show f <> show g <> show h)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn8 Int Int Int Int Int Int Int Int String)
    actual <- runEffectFn8 combined 1 2 3 4 5 6 7 8
    assertEqual { actual, expected: "L12345678R12345678" }
    emptyResult <- runEffectFn8 empty 1 2 3 4 5 6 7 8
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn9 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn9 (\a b c d e f g h i -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d <> show e <> show f <> show g <> show h <> show i)))
      right = opaque (mkEffectFn9 (\a b c d e f g h i -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d <> show e <> show f <> show g <> show h <> show i)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn9 Int Int Int Int Int Int Int Int Int String)
    actual <- runEffectFn9 combined 1 2 3 4 5 6 7 8 9
    assertEqual { actual, expected: "L123456789R123456789" }
    emptyResult <- runEffectFn9 empty 1 2 3 4 5 6 7 8 9
    assertEqual { actual: emptyResult, expected: "" }
  checkReplay "EffectFn10 Semigroup and Monoid" [1, 2] \_ -> do
    let
      left = opaque (mkEffectFn10 (\a b c d e f g h i j -> do
        _ <- mark 1
        pure ("L" <> show a <> show b <> show c <> show d <> show e <> show f <> show g <> show h <> show i <> show j)))
      right = opaque (mkEffectFn10 (\a b c d e f g h i j -> do
        _ <- mark 2
        pure ("R" <> show a <> show b <> show c <> show d <> show e <> show f <> show g <> show h <> show i <> show j)))
      combined = opaque (left <> right)
      empty = opaque (mempty :: EffectFn10 Int Int Int Int Int Int Int Int Int Int String)
    actual <- runEffectFn10 combined 1 2 3 4 5 6 7 8 9 10
    assertEqual { actual, expected: "L12345678910R12345678910" }
    emptyResult <- runEffectFn10 empty 1 2 3 4 5 6 7 8 9 10
    assertEqual { actual: emptyResult, expected: "" }
