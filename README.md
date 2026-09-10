# purescript-effect

[![Latest release](http://img.shields.io/github/release/purescript/purescript-effect.svg)](https://github.com/purescript/purescript-effect/releases)
[![Build status](https://github.com/purescript/purescript-effect/workflows/CI/badge.svg?branch=master)](https://github.com/purescript/purescript-effect/actions?query=workflow%3ACI+branch%3Amaster)
[![Pursuit](https://pursuit.purescript.org/packages/purescript-effect/badge)](https://pursuit.purescript.org/packages/purescript-effect)

The `Effect` monad, for handling native side effects.

## Installation

```
spago install effect
```

## Documentation

### Rust tests

Run `bin/test -c` from this package. The Bash runner rebuilds the sibling
`purust` compiler, clears this package's caches, generates fresh TAST and Rust,
then compiles and runs the tests with Cargo. `bin/test` skips the compiler
rebuild but still regenerates the test output. The sibling TAST-enabled
PureScript fork is selected automatically; `PURS=/path/to/purs` overrides it.

Both builds use Spago installed in the sibling compiler's `node_modules`
by `npm install`, so an older global or ancestor installation cannot take over.

The suite covers `Effect` and `Effect.Class`: 17 checks verify `pure`, `bind`,
mapping and application, sequencing, Semigroup/Monoid instances, polymorphic
`liftEffect`, and all four loops, including empty ranges, record elements,
condition order and nested loops. Each check verifies that construction has
no effects, then executes the same action twice and checks its trace and
result. Three separate processes verify that failures stop bind continuations
and subsequent `forE` iterations.

In addition, `Test.RefIntegration` retains the complete four-test suite from
`gopurs-effect`, with the same bodies and assertions: `forE`, `foreachE`,
`whileE` and `untilE` create, update and read real `Effect.Ref` values from
the sibling `purust-refs` package. The original 17 checks keep their test-only
Rust probe so they can also verify exact traces and action replay.

`Test.Adapters` adds 23 checks, also replayed twice. All ten `EffectFn`
arities exercise captured values, argument order, native Rust callbacks,
first-class makers and runners, and their Semigroup/Monoid instances.
The checks also cover record, function and nested `Effect` return values,
plus `unsafePerformEffect`. Opaque FFI boundaries ensure that the suite
exercises both optimizer intrinsics and the Rust adapter implementations.

### API

Values in PureScript do not have side-effects by default. This package provides
the standard type PureScript uses to handle "native" effects, i.e. effects
which are provided by the runtime system, and which cannot be emulated by pure
functions. Some examples of native effects are:

- Console IO
- Random number generation
- Exceptions
- Reading/writing mutable state

And in the browser:

- DOM manipulation
- XMLHttpRequest / AJAX calls
- Interacting with a websocket
- Writing/reading to/from local storage

All of these things may be represented in PureScript by the `Effect` type.
A value of the type `Effect a` represents a computation which may perform
some native effects, and which produces a value of the type `a` once it
finishes. For example, the module `Effect.Random` from `purescript-random`
exports a value `random`, whose type is `Effect Number`. When run, this
effect produces a random number between 0 and 1. To give another example,
the module `Effect.Console` exports a function `log`, whose type is
`String -> Effect Unit`. This function takes a string and produces an
effect which, when run, prints the provided string to the console.

```purescript
module RandomExample where
import Prelude
import Effect (Effect)
import Effect.Random (random)
import Effect.Console (log)

printRandom :: Effect Unit
printRandom = do
  n <- random
  log (show n)
```

In this example, `printRandom` is an effect which generates a random
number between 0 and 1 and prints it to the console. You can test it out
in the repl:

```
> import RandomExample
> printRandom
0.71831842260513870
unit
```

The `unit` is there because all effects must produce a value. When there
is nothing useful to return, we usually use the type `Unit`, which has
just one value: `unit`.

### Effects and Purity

Note that using `Effect` does not compromise the purity of your program.
Functions which make use of `Effect` are still pure, in the sense that
all functions will return the same outputs given the same inputs.

This is enabled by having the `Effect` type denote _values_ which can be
run to produce native effects; an `Effect a` is a computation which has
not yet necessarily been performed. In fact, there is no way of "running"
an `Effect` manually; we cannot provide a (safe) function of the type
`forall a. Effect a -> a`, because such a function would violate purity;
it could produce different outputs given the same input. (Note that there
is actually such a function in the module `Effect.Unsafe`, but it is best
avoided outside of exceptional circumstances.)

Instead, the recommended way of "running" an effect is to include it as
part of your program's `main` value.

A consequence of being able to represent native effects purely using
`Effect` is that you can construct and pass `Effect` values around your
programs freely. For example, we can write functions which can decide
whether to run a given effect just once, many times, or not at all:

```purescript
-- | Runs an effect three times, provided that the given condition is
-- | true.
thriceIf :: Boolean -> Effect Unit -> Effect Unit
thriceIf cond effect =
  if cond
    then do
      effect
      effect
      effect
    else
      pure unit
```

### Using Effects via the Foreign Function Interface

A computation of type `Effect a` is implemented in JavaScript as a
zero-argument function whose body is expected to perform its side-effects
before finally returning its result. For example, suppose we wanted a
computation which would increment a global counter and return the new
result each time it was run. We can implement this as follows:

```purescript
-- Counter.purs
foreign import incrCounter :: Effect Int
```

and in the corresponding JavaScript module:

```javascript
// Counter.js
exports.incrCounter = function () {
  if (!window.globalCounter) {
    window.globalCounter = 0;
  }
  return ++window.globalCounter;
};
```

For more information about the FFI (Foreign Function Interface), see
the [documentation repository](https://github.com/purescript/documentation).
This package also provides a module
[Effect.Uncurried](https://pursuit.purescript.org/packages/purescript-effect/docs/Effect.Uncurried)
to simplify the process of making uncurried effectful JavaScript functions
available to PureScript via the FFI.

### The Effect type is Magic

The PureScript compiler has special support for the `Effect` monad.
Ordinarily, a chain of monadic binds might result in poor performance when
executed. However, the compiler can generate code for the `Effect` monad
without explicit calls to the monadic bind function `>>=`.

Take the random number generation example from above. When compiled, the
compiler produces the following JavaScript:

```javascript
var printRandom = function __do() {
  var $0 = Effect_Random.random();
  return Effect_Console.log(Data_Show.show(Data_Show.showNumber)($0))();
};
```

whereas a more naive compiler might, for instance, produce:

```javascript
var printRandom = Control_Bind.bind(Effect.bindEffect)(Effect_Random.random)(
  function ($0) {
    return Effect_Console.log(Data_Show.show(Data_Show.showNumber)($0));
  }
);
```

While this is a small improvement, the benefit is greater when using
multiple nested calls to `>>=`.

### API reference

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-effect).
