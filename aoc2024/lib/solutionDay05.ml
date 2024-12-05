open Str

type rule = {
    before: int;
    after: int;
}

let filename = "../input/05/input.txt"

let sections =
  let contents = In_channel.with_open_bin filename
      In_channel.input_all in
    Str.split (regexp "\n\n") contents |> List.filter (fun e -> String.length e > 0)

let buildRule ls = match ls with
    | x :: y :: [] -> {before = int_of_string x; after = int_of_string y}
    | _ -> raise (Invalid_argument "Not reachable")

let extractRule str = String.split_on_char '|' str |> buildRule    
let extractRules = List.map extractRule 

let extractOrder str = String.split_on_char ',' str |> List.map (fun e -> int_of_string e)
let extractOrders = List.map extractOrder

let rules = List.hd sections |> String.split_on_char '\n' |> List.filter (fun e -> String.length e > 0)|> extractRules

let orders = match sections with
    | _ :: y :: [] -> String.split_on_char '\n' y |> List.filter (fun e -> String.length e > 0) |> extractOrders
    | _ -> raise (Invalid_argument "Not reachable")

let satisfies_rule order {before = a; after = b} = 
    let idx_a = List.find_index (fun e -> e == a) order in
    let idx_b = List.find_index (fun e -> e == b) order in
    match (idx_a, idx_b) with 
        | (Some f, Some l) -> f < l
        | _ -> true
        
let rec satisfies_rules order rules =  match rules with 
        | x :: y -> satisfies_rule order x && satisfies_rules order y
        | [] -> true

let extractMiddle ls = List.nth ls ((List.length ls) / 2) 

let solve_first = List.filter (fun e -> satisfies_rules e rules) orders |> List.map extractMiddle |> List.fold_right (+) 
let solve1 = solve_first 0

let compare_rule x y = 
    let rule = List.find_opt (fun e -> e.before == x && e.after == y) rules in
    match rule with
        | Some (_) -> 1
        | _ -> 0


let fix_order order = List.sort (fun x y -> compare_rule x y) order 

let solve_second = List.filter (fun e -> not (satisfies_rules e rules)) orders |> List.map fix_order |> List.map extractMiddle |> List.fold_right (+) 
let solve2 = solve_second 0

