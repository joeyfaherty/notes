#Functor:
Why are functors useful? 
They generalize multiple common idioms like collections, promises, optionals, etc. 
with a single, uniform API that works across all of them

#Applicative:

#Applicitive Functor:

#Monad:

#Monoid:

#Endofunctor:

# algebraic data type
algebraic data type is a kind of composite type, i.e., a type formed by combining other types
ie. Validation -> Type is a combination of Failure and Success. 

#high order function
does at least one of the following:
    takes one or more functions as arguments (i.e., procedural parameters),
    returns a function as its result.
All other functions are first-order functions.
High order function example:
Function<Function<Integer, Integer>, Function<Integer, Integer>> twice = f -> f.andThen(f);
twice.apply(x -> x + 3).apply(7);
answer: // 13

#default methods
- usually we have to implement all interface methods in a implementation 
- we do not have to implement deault methods in classes that implement the interface
- In ‘the strictest sense’, Default methods are a step backwards because they allow you to ‘pollute’ your interfaces with code. But they provide the most elegant and practical way to allow backwards compatibility




#Reactive:
Reactive programming, at least how I understand it, is the general term behind easily propagating changes through the 
execution of a prorgam. Its not a specific pattern or entity per-se, its an idea, or style of programming. Its the
 concept that when x changes in one location, the things that depend on the value of x are recalculated and updated 
 in various other locations with a minimum of fuss.

The observer pattern (at least in OO languages) is a common method for providing a "trigger" to allow information to be
 updated whenever such a change is made (or, in more common OO terms, when an "event" is fired.) In that sense, 
 it provides a mechanism for allowing the concept of reactive programming to happen in OO (and sometimes other) style languages.

observer:
With the Observer pattern, an Observable updates its Observers. 

Pub/Sub:
With Pub/Sub, 0-many publishers can publish messages of certain classes and 0-many subscribers can subscribe to messages of certain classes

Data binding:
Essentially, at the core this just means the value of property X on object Y is semantically bound to the value of property A on object B.
No assumptions are made as to how Y knows or is fed changes on object B.

Observer, or Observable/Observer:

A design pattern by which an object is imbued with the ability to notify others of specific events - typically done using actual events, which are kind of like slots in the object with the shape of a specific function/method. The observable is the one who provides notifications, and the observer receives those notifications. In .net, the observable can expose an event and the observer subscribes to that event with an "event handler"shaped hook. No assumptions are made about the specific mechanism which notifications occur, nor about the number of observers one observable can notify.

Pub/Sub:

Another name (perhaps with more "broadcast" semantics) of the Observable/Observer pattern, which usually implies a more "dynamic" flavor - observers can subscribe or unsubscribe to notifications and one observable can "shout out" to multiple observers. In .net, one can use the standard events for this, since events are a form of MulticastDelegate, and so can support delivery of events to multiple subscribers, and also support unsubscription. Pub/sub has a slightly different meaning in certain contexts, usually involving more "anonymity" between event and eventer, which can be facilitated by any number of abstractions, usually involving some "middle man" (such as a message queue) who knows all parties, but the individual parties dont know about each other.



# From the FP functional workshop

# Functional purity / lambda's

Evetything on the rhs of the arrow should be derived from the lhs of the arrow to adhere to functional purity.

(not accessing anything outside the function)  

# Function

takes an input and returns an output.

Deterministic. No Side effects.

Pure function - output should be dependant on input, not effecting external things outside the lambda.

andthen.. after

compose.. before

# BiFunction

# Supplier

Similar to a factory.  

supplier.get() 

optional.orElse().get .. only executed when there is no value. 

# Consumer

Heavily used in regression
accepts a single input argument and returns no result
takes an input. no output. 

# Tuple

is a finite ordered list of elements.

Wrapper for inputs/outputs when you want to input/output multiple values

# BiConsumer 

# Predicate

Represents a predicate (boolean-valued function) of one argument

# Functor

function applied to a wrapped value.

Apply function from a to b.

type, unit, map.

Optional is a typical functor. (value inside a context). 

Wrap and unwrap logic to check if there is a value present.

# Applicative Functor

wrapped function applied on a wrapped value

# Monad

function that returns warpped value applied on a wrapped value

- returns a wrapped value

3 rules,

left

right

associativity

flatmap .. unwraps the value, then accepts function that generates another optional, 

First: The term monad is a bit vacuous if you are not a mathematician. An alternative term is computation builder which is a bit more descriptive of what they are actually useful for.

# Parallels

Wrapper around CompletableFuture

future.get() is blocking... it will wait for the response or until the thread dies

future.get() can be used for assertions so that for assertion the response will have returned.

future.cancel() kills the thread

future.get() is never used in the application

# Forkjoin

# Validations (try monad)

no checked exceptions in j8 intefaces or our interfaces

left - failure

right - success

K.. Kleisli 

# Currying

Currying is the fact of evaluating function arguments one by one, producing a new function with one argument less on each step
# 
