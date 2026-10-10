import java.util.Map;
import java.util.LinkedHashMap;
import com.fasterxml.jackson.databind.ObjectMapper;

public class TestParse {
    public static void main(String[] args) throws Exception {
        String json = "{\"success\":true,\"panchanga\":{\"tithi\":{\"current\":{\"name\":\"Dwadashi\"}}}}";
        ObjectMapper mapper = new ObjectMapper();
        Map<?,?> response = mapper.readValue(json, Map.class);
        Map<?,?> panchanga = (Map<?,?>) response.get("panchanga");
        
        System.out.println("Tithi string: " + extractNested(panchanga, "tithi", "current", "name"));
    }

    private static String extractNested(Map<?,?> map, String... keys) {
        Object current = map;
        for (String key : keys) {
            if (!(current instanceof Map)) return "NOT_MAP";
            current = ((Map<?,?>) current).get(key);
        }
        return current != null ? current.toString() : "NULL";
    }
}
