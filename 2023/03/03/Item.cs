namespace _03;




public record Number(Coordinate[] AdjCoords, int Num);
public record Gear(IList<Number> Nums)
{
    public void Add(Number num)
    {
        Nums.Add(num);
    }
}

