package utils;

import model.Product;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Date;
import java.util.Map;

public class CacheManager {
    private static final long CACHE_DURATION = 30 * 60 * 1000;
    private static final ConcurrentHashMap<String, CacheEntry> cache = new ConcurrentHashMap<>();
    private static int cacheHits = 0;
    private static int cacheMisses = 0;

    private static class CacheEntry {
        private final Object data;
        private final long timestamp;

        public CacheEntry(Object data) {
            this.data = data;
            this.timestamp = System.currentTimeMillis();
        }

        public boolean isExpired() {
            return System.currentTimeMillis() - timestamp > CACHE_DURATION;
        }

        public long getAge() {
            return System.currentTimeMillis() - timestamp;
        }
    }

    public static void put(String key, Object value) {
        cache.put(key, new CacheEntry(value));
    }

    public static Object get(String key) {
        CacheEntry entry = cache.get(key);
        if (entry == null || entry.isExpired()) {
            cache.remove(key);
            cacheMisses++;
            return null;
        }
        cacheHits++;
        return entry.data;
    }

    public static void remove(String key) {
        cache.remove(key);
    }

    public static void clear() {
        cache.clear();
        cacheHits = 0;
        cacheMisses = 0;
    }

    private static double calculateHitRate() {
        int total = cacheHits + cacheMisses;
        if (total == 0) return 0.0;
        return (double) cacheHits / total * 100;
    }
} 