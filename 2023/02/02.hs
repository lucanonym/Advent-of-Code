import Data.Text(splitOn, pack, Text, lines, replace, unpack)
import Prelude hiding (lines)

type Red = Integer
type Blue = Integer
type Green = Integer
data Move = Test Integer Integer Integer

extractGame = pack "Game "
delimiter = pack ":"
replacement = pack ""
moveDelimiter = pack ";"
main = do 
    content <- readFile "resources/test.txt"
    print . part1 . lines $ pack content

gameIds :: [[Text]] -> [Integer]
gameIds = map unwrapId

part1 input = zip (gameIds $ parseInput input) (processMoves $ parseInput input)


parseInput :: [Text] -> [[Text]]
parseInput = map $ splitOn delimiter

processMoves :: [[Text]] -> [[Move]]
processMoves  = map $ parseMoves . head . tail

parseMoves :: Text -> [Move]
parseMoves = map $ toMove . splitOn moveDelimiter


unwrapId :: [Text] -> Integer
unwrapId str = read . unpack $ replace extractGame replacement $ head str

colorDelimiter = pack ","
toMove :: [Text] -> [Move]
toMove = splitOn  

