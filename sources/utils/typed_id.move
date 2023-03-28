module nft_protocol::typed_id {
    use sui::object::{Self, ID};

    /// An ID of an of type `T`. See `ID` for more details
    /// By construction, it is guaranteed that the `ID` represents an object of type `T`
    struct TypedID<phantom T: key> has copy, drop, store {
        id: ID,
    }

    /// Get the underlying `ID` of `obj`, and remember the type
    public fun new<T: key>(obj: &T): TypedID<T> {
        TypedID { id: object::id(obj) }
    }

    /// Borrow the inner `ID` of `typed_id`
    public fun as_id<T: key>(typed_id: &TypedID<T>): &ID {
        &typed_id.id
    }

    /// Get the inner `ID` of `typed_id`
    public fun to_id<T: key>(typed_id: TypedID<T>): ID {
        let TypedID { id } = typed_id;
        id
    }

    /// Check that underlying `ID` in the `typed_id` equals the objects ID
    public fun equals_object<T: key>(typed_id: &TypedID<T>, obj: &T): bool {
        typed_id.id == object::id(obj)
    }
}
