open Array

let filename = "../input/04/input.txt"
let pattern = "X" :: "M" :: "A" :: ["S"]
let mas_pattern = "M" :: "A" :: ["S"]

let string_to_list s = List.init (String.length s) (fun i -> String.make 1 s.[i])

let lines  =
    let contents = In_channel.with_open_bin filename
        In_channel.input_all in
    let singleLines = String.split_on_char '\n' contents in
    let filtered = List.filter (fun e -> String.length e > 0) singleLines in
    List.map string_to_list filtered

let create_Grid  = List.map (fun row -> of_list row) lines |> of_list

let matrix_get grid row col = Array.get (Array.get grid row) col

let getElem grid rowInd colInd = 
    if rowInd >= (length grid) || rowInd < 0 then "-" 
    else if colInd >= (Array.get grid rowInd |> Array.length) || colInd < 0 then "-"
    else matrix_get grid rowInd colInd 

let isMatch ls = if List.equal String.equal pattern ls then 1 else 0

let extractUpper grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid (rowInd - 1) colInd ) :: (getElem grid (rowInd - 2) colInd) :: (getElem grid (rowInd - 3) colInd) :: [] in
    isMatch res

let extractLeft grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid rowInd (colInd - 1)) :: (getElem grid rowInd (colInd - 2)) :: (getElem grid rowInd (colInd - 3)) :: [] in
    isMatch res

let extractLower grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid (rowInd + 1) colInd) :: (getElem grid (rowInd + 2) colInd) :: (getElem grid (rowInd + 3) colInd) :: [] in
    isMatch res

let extractRight grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid rowInd (colInd + 1)) :: (getElem grid rowInd (colInd + 2)) :: (getElem grid rowInd (colInd + 3)) :: [] in
    isMatch res


let extractUpperLeft grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid (rowInd - 1) (colInd - 1)) :: (getElem grid (rowInd - 2) (colInd - 2)) :: (getElem grid (rowInd - 3) (colInd - 3)) :: [] in
    isMatch res
let extractLowerRight grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid (rowInd + 1) (colInd + 1)) :: (getElem grid (rowInd + 2) (colInd + 2)) :: (getElem grid (rowInd + 3) (colInd + 3)) :: [] in
    isMatch res

let extractLowerLeft grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid (rowInd + 1) (colInd - 1)) :: (getElem grid (rowInd + 2) (colInd - 2)) :: (getElem grid (rowInd + 3) (colInd - 3)) :: [] in
    isMatch res

let extractUpperRight grid rowInd colInd = 
    let res = (getElem grid rowInd colInd) :: (getElem grid (rowInd - 1) (colInd + 1)) :: (getElem grid (rowInd - 2) (colInd + 2)) :: (getElem grid (rowInd - 3) (colInd + 3)) :: [] in
    isMatch res


let calcMatches grid rowInd colInd = 
    let upper = extractUpper grid rowInd colInd in
    let upperRight = extractUpperRight grid rowInd colInd in
    let right = extractRight grid rowInd colInd in
    let downRight = extractLowerRight grid rowInd colInd in
    let down = extractLower grid rowInd colInd in
    let downLeft = extractLowerLeft grid rowInd colInd in
    let left = extractLeft grid rowInd colInd in
    let upperLeft = extractUpperLeft grid rowInd colInd in
    upper + upperRight + right + downRight + down + downLeft + left + upperLeft

let findMatches grid rowInd colInd = match (matrix_get grid rowInd colInd) with
    | "X" -> calcMatches grid rowInd colInd
    | _ -> 0

let isMas ls = if List.equal String.equal mas_pattern ls || List.equal String.equal mas_pattern (List.rev ls) then 1 else 0

let extractLeftDiag grid row col = 
    let res = (getElem grid (row - 1) (col + 1)) :: (getElem grid row col) :: (getElem grid (row + 1) (col - 1)) :: [] in
    isMas res
let extractRightDiag grid row col = 
    let res = (getElem grid (row + 1) (col + 1)) :: (getElem grid row col) :: (getElem grid (row - 1) (col - 1)) :: [] in 
    isMas res
let calc_Mas_Matches grid rowInd colInd = 
    let upperLeftDiag = extractLeftDiag grid rowInd colInd in
    let upperRightDiag = extractRightDiag grid rowInd colInd in
    let sum = upperLeftDiag + upperRightDiag in
    if sum == 2 then 1 else 0

let findMatches2 grid rowInd colInd = match (matrix_get grid rowInd colInd) with
    | "A" -> calc_Mas_Matches grid rowInd colInd
    | _ -> 0

let findXmas grid row rowInd = Array.mapi (fun colI _ -> findMatches grid rowInd colI) row
let findMas grid row rowInd = Array.mapi (fun colI _ -> findMatches2  grid rowInd colI) row


let findMatch grid = Array.mapi (fun rowInd row -> findXmas grid row rowInd) grid

let findMatch2 grid = Array.mapi (fun rowInd row -> findMas grid row rowInd) grid

let solve = findMatch create_Grid |> Array.fold_right (fun l res -> Array.fold_right (+) l 0 + res) 
let solve1 = solve 0
let find2 = findMatch2 create_Grid |> Array.fold_right (fun l res -> Array.fold_right (+) l 0 + res) 
let solve2 = find2 0




