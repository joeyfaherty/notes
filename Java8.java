    private List<Command> getCommands(List<CommandDto> commandsDto) {
        List<Command> commands = commandsDto.stream()
                                            .map(commandDto -> new Command(
                                                    commandDto.getOp(), 
                                                    commandDto.getRef(),
                                                    commandDto.getParam(), 
                                                    commandDto.getE()))
                                            .collect(Collectors.toList());
        return commands;
    }


    private List<Command> getCommands(List<CommandDto> commandsDto) {
        List<Command> commands = new ArrayList<>();
        for (CommandDto commandDto : commandsDto) {
            commands.add(new Command(commandDto.getOp(), commandDto.getRef(),
                    commandDto.getParam(), commandDto.getE()));
        }
        return commands;
    }


List to Single Value Map example: Use .toMap
    static class Person {
        public int age;

        public Person(int age) {
            this.age = age;
        }

        public int getAge() {
            return age;
        }
    }

    public static void main(String[] args) {
        List<Person> persons = new ArrayList<>();
        persons.add(new Person(5));
        persons.add(new Person(8));

        Map<Integer, Person> map = persons.stream().collect(Collectors.toMap(person -> person.getAge(), person -> person));
        System.out.println();
    }

List to MultiValue Map example: Use .groupingBy
        private Map<Long, List<NodeChange>> convertToMap(List<Change> changes) {
        return changes
                .stream()
                // we don't send any notifications for channel nodes
                .filter(this::isPartOfMessage)
                .collect(groupingBy(n -> n.getNode().getNodeId()));
    }

<p>For example, to compute the set of last names of people in each city:
     * <pre>{@code
     *     Map<City, Set<String>> namesByCity
     *         = people.stream().collect(groupingBy(Person::getCity,
     *                                              mapping(Person::getLastName, toSet())));
     * }</pre>


private Map<Long, List<NodeChange>> convertToNodeChangeMap(List<NodeChange> nodeChanges) {
        Predicate<NodeChange> isPartOfNotificationMessage = this::isPartOfNotificationMessage;
        // input is NodeChange, output is long
        Function<NodeChange, Long> nodeChangeLongFunction = n -> n.getNode().getNodeId();
        return nodeChanges
                .stream()
                // we don't send any notifications for channel nodes
                .filter(isPartOfNotificationMessage)
                .collect(groupingBy(nodeChangeLongFunction));
    }

Predicate example: Use .filter
               nodeChanges
                .stream()
                // we don't send any notifications for channel nodes
                .filter(this::isPartOfNotificationMessage)
A java 8 Predicate takes an input and returns a boolean



this is an forEach abuse :) Create a method which converts one object to another and use map instead of foreach
    private List<CommandDto> convertCommandsDomainToDto(List<Command> commands) {
        return commands.stream()
                .map(c -> new CommandDto(
                        convertOpToDto(c.getOp()),
                        c.getRef(),
                        convertParamToDto(c.getParameter()),
                        c.getE()))
                .collect(Collectors.toList());
    }


// ScheduledExecutorService
class Beeper {
    
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    // beep every 4 seconds for an hour
    public void beepForAnHour() {
        Runnable beeper = () -> System.out.println("beep");
        final ScheduledFuture<?> beeperHandle = scheduler.scheduleAtFixedRate(() -> System.out.println("beep"), 10, 4, SECONDS);
        scheduler.schedule((Runnable) () -> beeperHandle.cancel(true), 60 * 60, SECONDS);
    }
}

public class TestScheduling {
    public static void main(String[] args) {
        Beeper beeper = new Beeper();
        beeper.beepForAnHour();
    }
}




    public static void main(String[] args) {
        List<String> l1 = Arrays.asList("x", "x", "y", "324", "abc");
        List<String> l2 = Arrays.asList("y", null, "y", "334", "54g");
        Map<String, List<String>> map = new HashMap<>();
        map.put("1", l1);
        map.put("2", l2);

        map.entrySet()
                .stream()
                .map(e -> e.getValue())
                .flatMap(Collection::stream)
                //.filter(e -> e != null)
                .filter(Objects::nonNull)
                .map(String::toUpperCase)
                .filter(s -> s.contains("A"))
                .forEach(System.out::println);
    }

    private static List<String> operation(Map<String, List<String>> map) {
        List<String> result = new ArrayList<>();
        for (Map.Entry<String, List<String>> entry : map.entrySet()) {
            if (entry.getKey().isEmpty()) {
                continue;
            }
            List<String> list = entry.getValue();
            if (list == null) {
                continue;
            }
            for (String s : list) {
                String trim = s.trim();
                if (trim.isEmpty()) {
                    continue;
                }
                result.add(trim);
            }
        }
        return result;
    }

    private static List<String> operationJava8(Map<String, List<String>> map) {
       return map.entrySet()
                .stream()
                .filter(e -> !e.getKey().isEmpty())
                .map(e -> e.getValue())
                //.filter(e -> e != null)
                .filter(Objects::nonNull)
                .flatMap(Collection::stream)
                .map(String::trim)
                .filter(trimmed -> !trimmed.isEmpty())
                .collect(Collectors.toList());
    }

Flatmap: flattens a data structure to one level:
{ {1,2}, {3,4}, {5,6} }             -> flatMap -> {1,2,3,4,5,6}
{ {'a','b'}, {'c','d'}, {'e','f'} } -> flatMap -> {'a','b','c','d','e','f'}
map and flatMap both output a Stream<R>

Monads:
Think of monads as an object that wraps a value and allows us to apply a set of transformations on that value and get it back out with all the transformations applied. That’s more or less it. We put a value in what’s called a monadic context, apply whatever functions we wish to it, and then grab our final value back out.

Optional Monad:
What if we had a monad that allowed us to wrap a potentially null value, 
perform some transformations on it for us if the value is not null. 
We could then just take the potentially null value, apply all our get operations to it 
and then pull out our value should one exist. That’s exactly what Optional does.

code to avoid a null pointer exception
public String getLastFour(Employee employee) {
    if(employee != null) {
        Address address = employee.getPrimaryAddress();
        if(address != null) {
            ZipCode zip = address.getZipCode();
            if(zip != null) {
                return zip.getLastFour()
            }
        }
    }
    throw new FMLException("Missing data");
}

public String getLastFour(Optional<Employee> employee) {
    return employee.flatMap(employee -> employee.getPrimaryAddress())
                   .flatMap(address -> address.getZipCode())
                   .flatMap(zip -> zip.getLastFour())
.orElseThrow(() -> new FMLException("Missing data"));

Dont do a null check in this way;
Optional<Person> person = personMap.get("Name");

if (person.isPresent()) {
  Optional<Adress> address = person.getAddress();
  if (address.isPresent()) {
    Optiona<City> city = address.getCity();
    if (city.isPresent()) {
      process(city)
    }
  }
}

personMap.find("Name")
   .flatMap(Person::getAddress)
   .flatMap(Address::getCity)
   .ifPresent(ThisClass::process);



BiFunction<Integer, Integer, String> result = (x, y) -> "Hello " + (x + y);
assertEquals(result.apply(6, 8), String.valueOf("Hello 14"));

BiFunction<String, String, String> sConcat = (x, y) -> ( x + y);
assertEquals(sConcat.apply("hell", "o"), "hello");
