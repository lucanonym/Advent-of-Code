namespace _03;

using System;
using System.IO;

public class FileOps(string path)
{
    public List<string> GetLines()
    {   
        return !File.Exists(path) ? [] : [..File.ReadAllLines(path)];
    }
}