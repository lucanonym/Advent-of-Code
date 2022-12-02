package org.example.util;

import java.util.Objects;

public class Pair<T, S> {
    private T firstItem;
    private S secondItem;
    public Pair(T firstItem, S secondItem) {
        this.firstItem = firstItem;
        this.secondItem = secondItem;
    }
    public Pair() {

    }

    public S getSecondItem() {
        return secondItem;
    }

    public T getFirstItem() {
        return firstItem;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pair<?, ?> pair = (Pair<?, ?>) o;
        return firstItem.equals(pair.firstItem) && secondItem.equals(pair.secondItem);
    }

    @Override
    public int hashCode() {
        return Objects.hash(firstItem, secondItem);
    }
}
