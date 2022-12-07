package org.example.days;

import org.example.util.FileParser;

import java.util.Arrays;
import java.util.List;
import java.util.Stack;

/**
 * This is only Task 2. For getting Task 01 you need to delete the stack and just pop and push until ready
 */

public class Day05 {

    public static void main(String[] args) {
        FileParser parser = new FileParser("/home/luca/IdeaProjects/AOC/src/main/resources/Tag5.txt");
        List<String> lines = parser.getLines();
        Stack<String>[] stacks = new Stack[9];
        for (int i = 0; i < stacks.length; i++) stacks[i] = new Stack<>();
        for (int i = 0; i < 9; i++) {
            int lineOfCargo = i * 4 + 1;
            int j = 7;
            while (j >= 0 && lines.get(j).length() >= lineOfCargo + 1
                    &&!lines.get(j).substring(lineOfCargo - 1, lineOfCargo + 2).isBlank()) {
                stacks[i].push(lines.get(j).substring(lineOfCargo - 1, lineOfCargo + 2));
                j--;
            }
        }
        for (int i = 10; i < lines.size(); i++) {
          String[] split = lines.get(i).split(" ");
          int amount = Integer.parseInt(split[1]);
          int from = Integer.parseInt(split[3]);
          int to = Integer.parseInt(split[5]);
          Stack<String> tempStack = new Stack<>();
          while (amount > 0) {
              String toPush = stacks[from - 1].pop();
              tempStack.push(toPush);
              amount--;
          }
          while (!tempStack.empty()) stacks[to - 1].push(tempStack.pop());


        }
        Arrays.stream(stacks).filter(stack -> !stack.empty()).forEach(stack -> System.out.println(stack.pop()));
    }

}

