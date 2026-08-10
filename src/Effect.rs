pub fn Effect_pureE(a: crate::UnknownType) -> crate::UnknownType {
    crate::UnknownType::new(std::rc::Rc::new(move |_: crate::UnknownType| -> crate::UnknownType {
        a.clone()
    }))
}

pub fn Effect_bindE(a: crate::UnknownType, f: crate::UnknownType) -> crate::UnknownType {
    crate::UnknownType::new(std::rc::Rc::new(move |_: crate::UnknownType| -> crate::UnknownType {
        // a is an Effect, f is (a -> Effect b). Both are functions of Unit.
        let a_fn = a.clone().into_rc_fn();
        let a_res = a_fn(crate::UnknownType::new(0));
        let f_fn1 = f.clone().into_rc_fn();
        let b_eff = f_fn1(a_res);
        let b_fn = b_eff.into_rc_fn();
        b_fn(crate::UnknownType::new(0))
    }))
}
pub type Effect = crate::UnknownType;
