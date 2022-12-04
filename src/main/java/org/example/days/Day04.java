package org.example.days;

import org.example.util.FileParser;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Day04 {
    public static void main(String[] args) {
        FileParser parser = new FileParser("/home/luca/IdeaProjects/AOC/src/main/resources/Tag4.txt");
        int res = parser.getLines().stream()
                .map(line -> line.replaceAll(System.lineSeparator(), ""))
                .map(line -> line.split(","))
                .map(line -> new String[][]{line[0].split("-"), line[1].split("-")})
                .map(line -> new int[][]{{Integer.parseInt(line[0][0]), Integer.parseInt(line[0][1])},
                        {Integer.parseInt(line[1][0]), Integer.parseInt(line[1][1])}})
                .filter(line -> line[0][0] >= line[1][0] && line[0][1] <= line[1][1]
                        || line[0][0] <= line[1][0] && line[0][1] >= line[1][1])
                .mapToInt(line -> 1)
                .sum();
        System.out.println("part1 equals " + res);
        int part2 = parser.getLines().stream()
                .map(line -> line.replaceAll(System.lineSeparator(), ""))
                .map(line -> line.split(","))
                .map(line -> new String[][]{line[0].split("-"), line[1].split("-")})
                .map(line -> new int[][]{{ Integer.parseInt(line[0][0]), Integer.parseInt(line[0][1])},
                        {Integer.parseInt(line[1][0]), Integer.parseInt(line[1][1])}})
                .filter(line -> getRange(line))
                .mapToInt(line -> 1)
                .sum();
        System.out.println("part2 equals " + part2);
        System.out.println(getRange(new int[][]{{6,6},{3,7}}));







    }
    private static boolean getRange(int[][] array) {
        Set<Integer> test = new HashSet(IntStream.rangeClosed(array[1][0], array[1][1]).boxed().collect(Collectors.toSet()));
        Set<Integer> test2 = new HashSet(IntStream.rangeClosed(array[0][0], array[0][1]).boxed().collect(Collectors.toSet()));
        Set<Integer> newTest = new HashSet<>(test);
        newTest.addAll(test2);
        return test.size() + test2.size() != newTest.size();


    }



}
