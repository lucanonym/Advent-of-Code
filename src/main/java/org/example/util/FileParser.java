package org.example.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;

public class FileParser {
    private List<String> lines = Collections.emptyList();
    private String stringOfLines;

    public FileParser(String path) {
        try {
            stringOfLines = Files.readString(Paths.get(path));
            lines = Files.readAllLines(Paths.get(path), StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<String> getLines() {
        return List.copyOf(lines);
    }
    public String getStringOfLines() {
        return this.stringOfLines;
    }
}
