import Data.Text(splitOn, pack, Text, lines, replace, unpack, strip, isInfixOf)
import Prelude hiding (lines)


data Move = Move {red :: Int, blue:: Int, green::Int}
    deriving (Eq, Show)
extractGame = pack "Game "
delimiter = pack ":"
replacement = pack ""
moveDelimiter = pack ";"
blueC = pack "blue"
redC = pack "red"
greenC = pack "green"

main = do
    content <- readFile "resources/test.txt"
    print . part1 . lines $ pack content

gameIds :: [[Text]] -> [Integer]
gameIds = map unwrapId

part1 :: [Text] -> [(Integer, [Move])]
part1 input = filter isPossible (zip (gameIds $ parseInput input) (parseMoves input))

parseMoves :: [Text] -> [[Move]]
parseMoves = map $ toMoves . splitOn moveDelimiter . head . tail . splitOn delimiter

toMoves :: [Text] -> [Move]
toMoves = map $ extractMove . splitOn colorDelimiter

extractMove :: [Text] -> Move
extractMove list = extractMoveRec list Move{red = 0, blue = 0, green = 0}

extractMoveRec :: [Text] -> Move -> Move
extractMoveRec [] mv = mv
extractMoveRec (fst:xs) (Move r b g)
    | blueC `isInfixOf` fst = extractMoveRec xs Move{
        red = r,
        blue = read . unpack $ replace blueC replacement fst,
        green = g}
    | redC `isInfixOf` fst = extractMoveRec xs Move{
        red = read . unpack $ replace redC replacement fst,
        blue = b,
        green = g}
    | greenC `isInfixOf` fst = extractMoveRec xs Move{
        red = r,
        blue = b,
        green = read . unpack $ replace greenC replacement fst}
    | otherwise = extractMoveRec xs Move {red = r, blue = b, green = g}

isPossible :: (Integer, [Move]) -> Bool
isPossible tp = foldr (\x y -> checkGame x && y) True (snd tp)

checkGame :: Move -> Bool
checkGame (Move r g b) = (r <= 12) && (g <= 13) && (b <= 14)

parseInput :: [Text] -> [[Text]]
parseInput = map $ splitOn delimiter

tpSum :: (Integer, [Move]) -> Integer -> Integer
tpSum tp x = fst tp + x

unwrapId :: [Text] -> Integer
unwrapId str = read . unpack $ replace extractGame replacement $ head str

colorDelimiter = pack ","


