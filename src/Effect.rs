pub fn Effect_pureE(a: crate::UnknownType) -> crate::UnknownType {
    crate::UnknownType::new(crate::Record_a { call: Some(std::rc::Rc::new(move |_: crate::UnknownType| -> crate::UnknownType {
        a.clone()
    })), ..Default::default() })
}

pub fn Effect_bindE(a: crate::UnknownType, f: crate::UnknownType) -> crate::UnknownType {
    crate::UnknownType::new(crate::Record_a { call: Some(std::rc::Rc::new(move |_: crate::UnknownType| -> crate::UnknownType {
        // a is an Effect, f is (a -> Effect b). Both are functions of Unit.
        let a_fn = a.clone().call.clone().unwrap();
        let a_res = a_fn(crate::UnknownType::new(Record_a { ..Default::default() }));
        let f_fn1 = f.clone().call.clone().unwrap();
        let b_eff = f_fn1(a_res);
        let b_fn = b_eff.call.clone().unwrap();
        b_fn(crate::UnknownType::new(Record_a { ..Default::default() }))
    })), ..Default::default() })
}
pub type Effect = crate::UnknownType;
