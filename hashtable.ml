module type HashTable = sig
    (** [t] is the type of hashtables. *)
    type ('a, 'b) t

    val make : int -> int -> int -> ('a, 'b) t

    val size : ('a, 'b) t -> int

    val is_empty : ('a, 'b) t -> bool

    val get : 'a -> ('a, 'b) t -> 'b option

    val put : 'a  -> 'b -> ('a, 'b) t -> unit
end

module HashTbl : HashTable = struct

    type ('a, 'b) hashtbl = ('a * 'b) list array
    type ('a, 'b) t = { scale: int; cap: int; mutable size: int; mutable table: ('a, 'b) hashtbl}

    let make s c n =
        {scale=s; cap=c; size=0; table=Array.make n []}

    let size t =
        t.size

    let is_empty t =
        size t = 0

    (** Returns the result of the hash function applied to [i]. *)
    let hash_fun (i:int) : int =
        failwith "unimplemented"

    (** Converts [k] into a (unique-ish) number. *)
    let num_of_key (k:'a) : int =
        failwith "unimplemented"

    (** Returns the result of the hash function applied to [k]
        and modded by the length of array [t]. *)
    let hash_num_of_key k t =
        let h = k |> num_of_key |> hash_fun in
        h mod (Array.length t)

    let num_buckets t =
        Array.length t.table

    let get k t =
        let i = hash_num_of_key k t.table in
        let l = t.table.(i) in
        List.assoc_opt k l

    (** [put t (k, v)] inserts (k, v) into the bucket array 
        [t] according to the hashfunction. *)
    let put' t (k, v) =
        let i = hash_num_of_key k t in
        let l = t.(i) in
        t.(i) <- (k, v)::l

    let resize t =
        let num_buckets = num_buckets t in
        let num_buckets' = num_buckets * t.scale in
        let tbl = Array.make num_buckets' [] in
        for x = 0 to num_buckets do
            let l = t.table.(x) in
            List.iter (put' tbl) l
        done;
        t.table <- tbl

    let put k v t = 
        let num_buckets = num_buckets t in
        let max = num_buckets * t.cap in
        (if size t + 1 > max then resize t
        else ());
        put' t.table (k, v);
        t.size <- t.size + 1
end