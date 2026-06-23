package edu.ifsp.microblog.util;

public final class StringUtil {
    private StringUtil() {}

    public static String emptyIfNull(String s) {
        return s == null ? "" : s;
    }
}