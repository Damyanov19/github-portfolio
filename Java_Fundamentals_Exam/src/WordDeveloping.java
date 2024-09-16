import java.util.Scanner;

public class WordDeveloping {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder strBuilder = new StringBuilder();

        while (true) {
            String[] command = scanner.nextLine().split("\\s+");
            String action = command[0];

            if (action.equals("End")) {
                break;
            }

            switch (action) {
                case "Add":
                    String substring = command[1];
                    strBuilder.append(substring);
                    break;

                case "Upgrade":
                    char charToUpgrade = command[1].charAt(0);
                    for (int i = 0; i < strBuilder.length(); i++) {
                        if (strBuilder.charAt(i) == charToUpgrade) {
                            char upgradedChar = (char) (charToUpgrade + 1);
                            strBuilder.setCharAt(i, upgradedChar);
                        }
                    }
                    break;

                case "Print":
                    System.out.println(strBuilder.toString());
                    break;

                case "Index":
                    char charToFind = command[1].charAt(0);
                    boolean found = false;
                    for (int i = 0; i < strBuilder.length(); i++) {
                        if (strBuilder.charAt(i) == charToFind) {
                            System.out.print(i + " ");
                            found = true;
                        }
                    }
                    if (!found) {
                        System.out.println("None");
                    } else {
                        System.out.println();
                    }
                    break;

                case "Remove":
                    String substringToRemove = command[1];
                    int index;
                    while ((index = strBuilder.indexOf(substringToRemove)) != -1) {
                        strBuilder.delete(index, index + substringToRemove.length());
                    }
                    break;
            }
        }

        scanner.close();
    }
}
