//import java.util.Scanner;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//public class MessageEncrypter {
//    public static void main(String[] args) {
//        Scanner scanner = new Scanner(System.in);
//
//        int n = Integer.parseInt(scanner.nextLine());
//
//        for (int i = 0; i < n; i++) {
//            String input = scanner.nextLine();
//            String pattern = "([@*])([A-Z][a-z]{2,})\\1: \\[([A-Za-z])\\]\\|\\[([A-Za-z])\\]\\|\\[([A-Za-z])\\]\\|";
//
//            Pattern regex = Pattern.compile(pattern);
//            Matcher matcher = regex.matcher(input);
//
//            if (matcher.find()) {
//                System.out.print(matcher.group(2) + ": ");
//                for (int j = 3; j <= 5; j++) {
//                    System.out.print((int) matcher.group(j).charAt(0) + " ");
//                }
//                System.out.println();
//            } else {
//                System.out.println("Valid message not found!");
//            }
//        }
//
//        scanner.close();
//    }
//}
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MessageProcessor {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        Pattern pattern = Pattern.compile("([*@])(?<tag>[A-Z][a-z]{2,})\\1:\\s\\[(?<group1>[A-Za-z])\\]\\|\\[(?<group2>[A-Za-z])\\]\\|\\[(?<group3>[A-Za-z])\\]\\|$");

        for (int i = 0; i < n; i++) {
            String input = scanner.nextLine();
            Matcher matcher = pattern.matcher(input);

            if (matcher.matches() && matcher.group("tag").equals(matcher.group(2))) {
                String tag = matcher.group("tag");
                String group1 = matcher.group("group1");
                String group2 = matcher.group("group2");
                String group3 = matcher.group("group3");

                int num1 = (int) group1.charAt(0);
                int num2 = (int) group2.charAt(0);
                int num3 = (int) group3.charAt(0);

                System.out.printf("%s: %d %d %d%n", tag, num1, num2, num3);
            } else {
                System.out.println("Valid message not found!");
            }
        }
        scanner.close();
    }
}








