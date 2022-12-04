package org.example.days;

import org.example.util.FileParser;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;



public class Day03 {
    public static void main(String ... args) {
        FileParser parser = new FileParser("/home/luca/IdeaProjects/AOC/src/main/resources/Tag3.txt");
        int res = parser.getLines().stream().map(e -> new String[]{e.substring(0, e.length() / 2), e.substring(e.length() / 2)})
                .mapToInt(e -> getPrio(e[0]).filter(i -> getPrio(e[1]).anyMatch(j -> j == i)).findFirst().getAsInt())
                        .sum();
        System.out.println("first puzzle " + res);

        String[] s = parser.getLines().stream().toArray(String[]::new);
        int test =  IntStream.range(0, s.length/3)
                .map(x -> x * 3)
                .map(x -> getPrio(s[x]).filter(i -> getPrio(s[x+1]).anyMatch(j -> j == i) && getPrio(s[x+2]).anyMatch(j -> j == i)).findFirst().getAsInt())
                .sum();
        System.out.println(test);







    }
    private static IntStream getPrio(String str) {
        return str.chars().map(s -> s <= 'z' && s >= 'a' ? s - 'a' + 1 : s - 'A' + 26 + 1);
    }
}
