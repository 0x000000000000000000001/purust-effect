use std::cell::RefCell;
use std::rc::Rc;

#[derive(Default)]
struct TestProbe {
    trace: Vec<i64>,
    ticks: i64,
}

thread_local! {
    static PROBE: RefCell<TestProbe> = RefCell::new(TestProbe::default());
}

fn test_effect(action: impl Fn() -> Value + 'static) -> UnknownType {
    Value::Func1(purust_core::Func1::Shared(Rc::new(move |_| action())))
}

pub fn Test_Probe_scenario() -> i64 {
    std::thread::spawn(|| {
        std::thread::sleep(std::time::Duration::from_secs(10));
        eprintln!("Effect test timed out after 10 seconds");
        std::process::exit(124);
    });
    std::env::args().nth(1).expect("scenario argument").parse().expect("integer scenario")
}

pub fn Test_Probe_mark(value: i64) -> UnknownType {
    test_effect(move || {
        PROBE.with(|state| state.borrow_mut().trace.push(value));
        mk_int(value)
    })
}

pub fn Test_Probe_tick() -> UnknownType {
    test_effect(|| PROBE.with(|state| {
        let mut state = state.borrow_mut();
        state.ticks += 1;
        let value = state.ticks;
        state.trace.push(value);
        mk_int(value)
    }))
}

pub fn Test_Probe_fail() -> UnknownType {
    test_effect(|| panic!("intentional Effect failure"))
}

pub fn Test_Probe_checkReplay(
    label: String,
    expected: UnknownType,
    factory: purust_core::Func1<(), UnknownType>,
) -> UnknownType {
    test_effect(move || {
        let expected: Vec<i64> = expected.unwrap_array().iter().map(|value| value.unwrap_int()).collect();
        PROBE.with(|state| *state.borrow_mut() = TestProbe::default());
        let action = factory(());
        PROBE.with(|state| assert!(state.borrow().trace.is_empty(), "{} ran during construction", label));
        for execution in 1..=2 {
            PROBE.with(|state| *state.borrow_mut() = TestProbe::default());
            assert!(matches!(action.unwrap_func1()(Value::Unit), Value::Unit), "{} must return Unit", label);
            PROBE.with(|state| assert_eq!(state.borrow().trace, expected, "{}, execution {}", label, execution));
        }
        println!("[OK] {}", label);
        Value::Unit
    })
}
