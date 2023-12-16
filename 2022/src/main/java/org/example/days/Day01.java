package org.example.days;


import org.example.util.FileParser;

import java.util.List;


public class Day01 {
    public static void main(String[] args) {
        String lineSeparator = System.lineSeparator();
        FileParser parser = new FileParser("/home/luca/IdeaProjects/AOC/src/main/resources/Tag1.txt");
        List<String> lines = parser.getLines();
        int highest = 0;
        int currentElf = 0;
        int second = 0;
        int third = 0;



        for (String line : lines) {
            if (line.equals("")) {
                if (currentElf > highest) {
                    third = second;
                    second = highest;
                    highest = currentElf;

                } else if (currentElf > second) {
                    third = second;
                    second = currentElf;

                } else if (currentElf > third) {
                    third = currentElf;

                }
                currentElf = 0;


            } else {
                try {
                    currentElf += Integer.parseInt(line);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        int res = third + second + highest;
        System.out.println(res);
    }


}