let filename = "../input/02/input.txt"

type dir = ASC | DESC
let lines f =
    let contents = In_channel.with_open_bin f
        In_channel.input_all in
    let singleLines = String.split_on_char '\n' contents in

    let filtered = List.filter (fun e -> String.length e > 0) singleLines in

    List.map (fun l -> String.split_on_char ' ' l) filtered

let parseNums = List.map (fun e -> int_of_string e)
let numbers = lines filename |> List.map (fun l -> parseNums l)

let checkItem prev x dir = match dir with 
        | ASC -> prev < x && abs (x - prev) <= 3
        | DESC -> prev > x && abs (x - prev) <= 3

let rec check list prev dir = match list with 
        | x :: y -> (checkItem prev x dir) && (check y x dir)
        | [] -> true

let isValid list = match list with 
    | (x :: y :: z) -> if x < y then check (y :: z) x ASC 
        else if x > y then check (y :: z) x DESC 
        else false
    | _ -> false

let rec isValidRec first second = match second with
    | x :: y -> isValid (first @ y) || isValidRec (first @ [x]) y
    | [] -> isValid first

let isValidWTolerance list = match list with
    | x :: y -> isValid y || isValidRec [x] y
    | [] -> true
        

let solve1 = List.filter (fun e -> isValid e) numbers |> List.length
let solve2 = List.filter (fun e -> isValidWTolerance e) numbers |> List.length





