module type KeySig = sig
    type t
end

module type ValueSig = sig
    type t
end

module type HashFunction = sig

    module Key : KeySig

    type key = Key.t

    val max : int

    val f : key -> int
end


module type HashTable = sig

    module Key : KeySig

    module Value : ValueSig

    module Fun : HashFunction

    (** [key] is the type representing keys in the hashtable. *)
    type key = Key.t
    (** [value] is the type representing values in the hashtable. *)
    type value = Value.t

    (** [t] is the type of hashtables. *)
    type t

    (** [rep_ok t] checks if [t] satisfies the hashtable representation invariant. If it does,
        it will return [t]. If not, raises [Failure].
        Raises: [Failure]
                 if [t] doesn't satisfy the representation invariant. *)
    val rep_ok : t -> t

    (** [empty] is an empty hashtable. *)
    val empty : t

    (** [is_empty t] returns true if [t] is empty, else it returns false. *)
    val is_empty : t -> bool

    (** [size t] is the number of entries in [t]. *)
    val size : t -> int

    (** [get k t] returns [Some v] if [v] is associated to key [k] in [t], else returns [None]. *)
    val get : key -> t -> value option

    (** [put k v t] inserts the value [v] associated to key [k] into [t] and returns unit.
        If [k] already exists in the table, [v] overrides its current value. *)
    val put : key  -> value -> t -> unit
end

module type MakeHashTable = functor (K : KeySig) (V : ValueSig) (F : HashFunction) ->
    HashTable with module Key = K and module Value = V and module Fun = F