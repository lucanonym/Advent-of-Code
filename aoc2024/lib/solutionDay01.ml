let first lst = List.hd lst

let rec last lst =
  match lst with
  | [] -> failwith "list empty"
  | [x] -> x
  | _::tl -> last tl

(* read file into a string list - every line is an element *)
let lines f =
  let contents = In_channel.with_open_bin f
      In_channel.input_all in
  String.split_on_char '\n' contents

(****** END of helper functions ******)


let file = "../input/01/input.txt"

(* get data and filter out empty lines -- last one was empty *)
let data =  lines file
            |> List.filter (fun x -> (String.length x) > 0)

(* get left & right values of every string -> convert to INT -> sort list *)
let left = List.map
    (fun x -> String.split_on_char ' ' x |> first |> int_of_string) data
         |>  List.sort compare

let right = List.map
    (fun x -> String.split_on_char ' ' x |> last |> int_of_string) data
         |>  List.sort compare

let solve1 =
  let diff = List.map2 (fun x y -> abs(x - y)) left right in
  List.fold_left (+) 0 diff

let solve2 =
  let occur v lst =
    List.find_all (fun x -> x = v) lst |> List.length
  in
  let simm = List.map (fun x -> x * occur x right) left in
  List.fold_left (+) 0 simm
