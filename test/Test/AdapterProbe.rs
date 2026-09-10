pub fn Test_AdapterProbe_opaque(value: UnknownType) -> UnknownType {
    value
}

pub fn Test_AdapterProbe_evaluate(callback: purust_core::Func1<(), UnknownType>) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback(())
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn1(callback: UnknownType, a: i64) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func1()(mk_int(a))
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn2(callback: UnknownType, a: i64, b: i64) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func2()(mk_int(a), mk_int(b))
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn3(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func3()(mk_int(a), mk_int(b), mk_int(c))
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn4(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func4()(mk_int(a), mk_int(b), mk_int(c), mk_int(d))
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn5(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
    e: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func5()(mk_int(a), mk_int(b), mk_int(c), mk_int(d), mk_int(e))
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn6(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
    e: i64,
    f: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func6()(
            mk_int(a),
            mk_int(b),
            mk_int(c),
            mk_int(d),
            mk_int(e),
            mk_int(f),
        )
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn7(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
    e: i64,
    f: i64,
    g: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func7()(
            mk_int(a),
            mk_int(b),
            mk_int(c),
            mk_int(d),
            mk_int(e),
            mk_int(f),
            mk_int(g),
        )
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn8(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
    e: i64,
    f: i64,
    g: i64,
    h: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func8()(
            mk_int(a),
            mk_int(b),
            mk_int(c),
            mk_int(d),
            mk_int(e),
            mk_int(f),
            mk_int(g),
            mk_int(h),
        )
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn9(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
    e: i64,
    f: i64,
    g: i64,
    h: i64,
    i: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func9()(
            mk_int(a),
            mk_int(b),
            mk_int(c),
            mk_int(d),
            mk_int(e),
            mk_int(f),
            mk_int(g),
            mk_int(h),
            mk_int(i),
        )
    })))
}

pub fn Test_AdapterProbe_invokeEffectFn10(
    callback: UnknownType,
    a: i64,
    b: i64,
    c: i64,
    d: i64,
    e: i64,
    f: i64,
    g: i64,
    h: i64,
    i: i64,
    j: i64,
) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(std::rc::Rc::new(move |_| {
        callback.unwrap_func10()(
            mk_int(a),
            mk_int(b),
            mk_int(c),
            mk_int(d),
            mk_int(e),
            mk_int(f),
            mk_int(g),
            mk_int(h),
            mk_int(i),
            mk_int(j),
        )
    })))
}
