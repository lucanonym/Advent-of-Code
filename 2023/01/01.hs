import Data.Char (isDigit, digitToInt)

main :: IO ()
main = do
    contents <- readFile "resources/input.txt"
    print $ part1 $ lines contents
    print $ part2 contents

part2 :: String -> Int
part2 = sum . getInts . map transNum . lines

part1 :: [String] -> Int
part1 =  sum . getInts

getInts :: [String] -> [Int]
getInts = map (read . sumLine . filterNumeric)


sumLine :: String -> String
sumLine [] = "0"
sumLine [x] = x : [x]
sumLine x = head x : [last x]

filterNumeric :: String -> String
filterNumeric  = filter isDigit

transNum :: String -> String
transNum [] = ""
transNum ('o':'n':'e':xs) = '1' : transNum ('e' : xs)
transNum ('t':'w':'o':xs) = '2' : transNum ('o' : xs)
transNum ('t':'h':'r':'e':'e':xs) = '3' : transNum ('e': xs)
transNum ('f':'o':'u':'r':xs) = '4' : transNum xs
transNum ('f':'i':'v':'e':xs) = '5' : transNum ('e' : xs)
transNum ('s':'i':'x':xs) = '6' : transNum xs
transNum ('s':'e':'v':'e':'n':xs) = '7' : transNum ('n' : xs)
transNum ('e':'i':'g':'h':'t':xs) = '8' : transNum ('t' : xs)
transNum ('n':'i':'n':'e':xs) = '9' : transNum ('e':xs)
transNum (x:xs) = x : transNum xs
