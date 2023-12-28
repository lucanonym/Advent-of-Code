using System.Collections;

namespace _03;

public static class Parser
{
    public static void ParseLine(int depth, string line, Dictionary<Coordinate, char> lookup, List<Number> items)
    {
        List<char> numStack = new List<char>();
        bool parseNum = false;
        for (int i = 0; i < line.Length; i++)
        {
            var c = line[i];
            if (char.IsNumber(c))
            {
                lookup.Add(new Coordinate(i, depth), c);
                parseNum = true;
                numStack.Add(c);
            } else if (parseNum)
            {
                parseNum = false;
                ExtractNum(depth, items, numStack, i);
            }
            if (!IsDot(c) && !char.IsNumber(c))
            {
                lookup.Add(new Coordinate(i, depth), c);
            }
        }
        if (parseNum)
        {
           ExtractNum(depth, items, numStack, line.Length);
        }
    }

    private static void ExtractNum(int depth, ICollection<Number> items, List<char> numStack, int i)
    {
        int item = Convert.ToInt32(string.Join("", numStack));
        var coords = GetCoordsForInt(depth, i - 1, numStack);
        numStack.Clear();
        items.Add(new Number(coords.ToArray(), item));
    }

    private static List<Coordinate> GetCoordsForInt(int depth, int currLength, ICollection digits)
    {
        var list = new List<Coordinate>();
        var i = -1;
        while (i <= digits.Count)
        {
            list.Add(new Coordinate(currLength - i,depth - 1));
            list.Add(new Coordinate(currLength - i,depth + 1));
            i++;
        }
         // Add before and after num
        list.Add(new Coordinate(currLength + 1, depth));
        list.Add(new Coordinate(currLength + 1 - i, depth));
       return list;
    }
    private static bool IsDot(char c)
    {
        return c == '.';
    }
}