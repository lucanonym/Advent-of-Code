open Str


let filename = "../input/03/input.txt"

let regex = Str.regexp "mul([0-9][0-9]?[0-9]?,[0-9][0-9]?[0-9]?)"
let numRegex = Str.regexp "[0-9][0-9]?[0-9]?"
let do_Regex = Str.regexp "do()"
let dont_Regex = Str.regexp "don't()"

let lines f =
  let contents = In_channel.with_open_bin f
      In_channel.input_all in contents

let extractMult str = 
    let _ = search_forward numRegex str 0  in
    let firstNum = matched_string str in
    let idx = match_end () in
    let _ = search_forward numRegex str idx in
    let secondNum = matched_string str in
    (int_of_string firstNum) * (int_of_string secondNum)

let rec find_matches str acc pos max =
    try
        let _ = search_forward regex str pos in 
        let found = matched_string str in 
        let last = match_end () in 
        if (last <= max) then find_matches str (extractMult found :: acc) last max
        else acc
    with Not_found  -> acc

let rec capture_do str acc pos = 
    try
        let dont = search_forward dont_Regex str pos in
        let doPos = search_forward do_Regex str dont in
        capture_do str (find_matches str acc pos dont) doPos
    with Not_found -> find_matches str acc pos (String.length str)


let solve1 = 
    let content = lines filename in 
    let results = find_matches content [] 0 (String.length content) in
    List.fold_right (+) results 0

let solve2 = 
    let content = lines filename in 
    let results = capture_do content [] 0 in
    List.fold_right (+) results 0



 
