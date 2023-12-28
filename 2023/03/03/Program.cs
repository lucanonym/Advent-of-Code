using _03;

FileOps op = new FileOps("/Users/lucapallo/projects/aoc/AOC/2023/03/03/resources/input.txt");
var lines = op.GetLines();
var dict = new Dictionary<Coordinate, char>();
var nums = new List<Number>();
for (int i = 0; i < lines.Count; i++)
{
    Parser.ParseLine(i, lines[i], dict, nums);
}
var sum = 0;
foreach (var t in nums)
{
    bool hasNum = t.AdjCoords
        .Select(coord => dict.ContainsKey(coord))
        .Aggregate(false, (b, b1) => b || b1);
    if (hasNum) sum += t.Num;
}

var part2Gears = dict
    .Where(elem => elem.Value == '*')
    .Select(gear => 
        new KeyValuePair<Coordinate, Gear>(gear.Key, new Gear(new List<Number>())))
    .ToDictionary();

foreach (var elem in nums)
{
    elem.AdjCoords.ToList().ForEach(coord =>
    { 
        var foundGear = part2Gears.GetValueOrDefault(coord, new Gear(new List<Number>()));
        foundGear.Add(elem);
    });
}

int part2 = part2Gears
    .Where(gear => gear.Value.Nums.ToList().Count == 2)
    .Select(gear => gear.Value.Nums[0].Num * gear.Value.Nums[1].Num)
    .Sum();

Console.WriteLine("Part 1 is: {0:D}", sum);
Console.WriteLine("Part 2 is: {0:D}", part2);
