package org.example.days;

import org.example.util.FileParser;
import org.example.util.Pair;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Day02 {
    public static void main(String[] args) {
        Map<Pair<String, String>, Integer> pointMap1 = new HashMap<>();
        FileParser parser = new FileParser("/home/luca/IdeaProjects/AOC/src/main/resources/Tag2.txt");
        List<String> lines = parser.getLines();
        pointMap1.put(new Pair<>("A", "Y"), 8);
        pointMap1.put(new Pair<>("A", "X"), 4);
        pointMap1.put(new Pair<>("A", "Z"), 3);
        pointMap1.put(new Pair<>("B", "Y"), 5);
        pointMap1.put(new Pair<>("B", "X"), 1);
        pointMap1.put(new Pair<>("B", "Z"), 9);
        pointMap1.put(new Pair<>("C", "Y"), 2);
        pointMap1.put(new Pair<>("C", "X"), 7);
        pointMap1.put(new Pair<>("C", "Z"), 6);
        Map<Pair<String, String>, Integer> pointMap2 = new HashMap<>();
        pointMap2.put(new Pair<>("A", "Y"), 4);
        pointMap2.put(new Pair<>("A", "X"), 3);
        pointMap2.put(new Pair<>("A", "Z"), 8);
        pointMap2.put(new Pair<>("B", "Y"), 5);
        pointMap2.put(new Pair<>("B", "X"), 1);
        pointMap2.put(new Pair<>("B", "Z"), 9);
        pointMap2.put(new Pair<>("C", "Y"), 6);
        pointMap2.put(new Pair<>("C", "X"), 2);
        pointMap2.put(new Pair<>("C", "Z"), 7);
        // x = loose, y = draw, Z = win
        // A = Rock, B = Paper, C = scissors
        int sum = lines.stream()
                .mapToInt(line -> pointMap1.get(new Pair<>(String.valueOf(line.charAt(0)), String.valueOf(line.charAt(2)))))
                .sum();
        System.out.println(sum);
        int sum2 = lines.stream()
                .mapToInt(line -> pointMap2.get(new Pair<>(String.valueOf(line.charAt(0)), String.valueOf(line.charAt(2)))))
                .sum();
        System.out.println(sum2);




    }
}
