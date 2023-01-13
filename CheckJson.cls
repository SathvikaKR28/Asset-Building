public class CheckJson {
    public static String checkjsonparse(SObject ord){
        String s = String.valueOf(ord);
        List<String> l = s.split('=',2);
        return l[1];
    }
}