pub fn Effect_Unsafe_unsafePerformEffect(action: UnknownType) -> UnknownType {
    action.unwrap_func1()(Value::Unit)
}
