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
colorDelimiter = pack ","

main = do
    content <- readFile "resources/input.txt"
    print . part1 . lines $ pack content
    print . part2 . lines $ pack content

gameIds :: [[Text]] -> [Integer]
gameIds = map unwrapId

part1 :: [Text] -> Integer
part1 input = foldr tpSum 0 $ filter isPossible (zip (gameIds $ parseInput input) (parseMoves input))

part2 input = foldr multTp 0 $ zipWith (curry powerHigh) (gameIds $ parseInput input) (parseMoves input)

powerHigh :: (Integer, [Move]) -> Move
powerHigh tp = maxGame $ snd tp

multTp :: Move -> Int -> Int
multTp (Move r b g) x = r * b * g + x
maxGame :: [Move] -> Move
maxGame = foldr maxTp (Move 0 0 0)

maxTp :: Move -> Move -> Move
maxTp (Move r1 b1 g1) (Move r2 b2 g2) = Move {
    red = max r1 r2,
    blue = max b1 b2,
    green = max g1 g2
}

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
checkGame (Move r b g) = (r <= 12) && (g <= 13) && (b <= 14)

parseInput :: [Text] -> [[Text]]
parseInput = map $ splitOn delimiter

tpSum :: (Integer, [Move]) -> Integer -> Integer
tpSum tp x = fst tp + x

unwrapId :: [Text] -> Integer
unwrapId str = read . unpack $ replace extractGame replacement $ head str

