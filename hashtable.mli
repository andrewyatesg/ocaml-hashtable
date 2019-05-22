module type HashTable = sig
    (** [t] is the type of hashtables. *)
    type ('a, 'b) t

    (** [make s c n] returns an empty hashtable with [n] buckets
        and scale factor [s] and capacity [c] ([MAX_ENTRIES] = [n*c]).
        Raises: [Invalid_argument] if [n] is not positive. *)
    val make : int -> int -> int -> ('a, 'b) t

    (** [size t] is the number of entries in [t]. *)
    val size : ('a, 'b) t -> int

    (** [is_empty t] returns true if [t] is empty, else it returns false. *)
    val is_empty : ('a, 'b) t -> bool

    (** [get k t] returns [Some v] if [v] is associated to key [k] in [t], else returns [None]. *)
    val get : 'a -> ('a, 'b) t -> 'b option

    (** [contains k t] returns true iff [k] is associated to some value in [t]. *)
    val contains : 'a -> ('a, 'b) t -> bool

    (** [put k v t] inserts the value [v] associated to key [k] into [t] and returns unit.
        If [k] already exists in the table, [v] overrides its current value. *)
    val put : 'a  -> 'b -> ('a, 'b) t -> unit
end

module HashTbl : HashTable