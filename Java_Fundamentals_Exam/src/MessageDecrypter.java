import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MessageDecrypter {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        Pattern pattern= Pattern.compile("^([$%])(?<tag>[A-Z][a-z]{3,})\\1(:\\s)(\\[(?<digits>[0-9]+)]\\|){3}$");
        for (int i = 0; i < n; i++) {
            String encryptedMsg = scanner.nextLine();
            Matcher matcher = pattern.matcher(encryptedMsg);
            if (matcher.find()){
                String tag = matcher.group("tag");
                String encryptedPart = encryptedMsg.substring(encryptedMsg.indexOf(':') + 2, encryptedMsg.length() - 1);
                String []numbersList = encryptedPart.split("\\|");
                StringBuilder decryptedMsg = new StringBuilder();
                for (String group: numbersList){
                    if (!group.isEmpty()){
                        String numberStr = group.replaceAll("[\\[\\]]", "");
                        int number = Integer.parseInt(numberStr);
                        decryptedMsg.append((char) number);
                    }
                }
                System.out.printf("%s: %s%n",tag,decryptedMsg);
            }else {
                System.out.println("Valid message not found!");
            }
        }
    }
}