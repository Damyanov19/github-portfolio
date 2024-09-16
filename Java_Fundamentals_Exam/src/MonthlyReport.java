import java.math.BigDecimal;
import java.util.*;

public class MariaBakery {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        Map<String, BigDecimal> clients = new LinkedHashMap<>();
        Map<String, BigDecimal> distributors = new LinkedHashMap<>();

        String input;
        while (!(input = scanner.nextLine()).equals("End")) {
            String[] tokens = input.split("\\s+");
            String command = tokens[0];
            String name = tokens[1];
            BigDecimal amount = new BigDecimal(tokens[2]);

            switch (command) {
                case "Deliver":
                    distributors.putIfAbsent(name, BigDecimal.ZERO);
                    distributors.put(name, distributors.get(name).add(amount));
                    break;
                case "Return":
                    if (distributors.containsKey(name) && distributors.get(name).compareTo(amount) >= 0) {
                        distributors.put(name, distributors.get(name).subtract(amount));
                        if (distributors.get(name).compareTo(BigDecimal.ZERO) == 0) {
                            distributors.remove(name);
                        }
                    }
                    break;
                case "Sell":
                    clients.putIfAbsent(name, BigDecimal.ZERO);
                    clients.put(name, clients.get(name).add(amount));
                    break;
            }
        }

        // Print clients and money spent by each of them
        clients.forEach((client, money) -> System.out.printf("%s: %.2f%n", client, money));

        System.out.println("-----------");

        // Print distributors and total cost of ingredients purchased from distributors
        distributors.forEach((distributor, money) -> System.out.printf("%s: %.2f%n", distributor, money));

        System.out.println("-----------");

        // Print total money spent by customers
        BigDecimal totalIncome = clients.values().stream().reduce(BigDecimal.ZERO, BigDecimal::add);
        System.out.printf("Total Income: %.2f%n", totalIncome);
    }
}
