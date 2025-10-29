The Bouncy Path
===============
To
===
Trampolines
===========

### Nathan Hessler

---

## The Reality

* only two talks left then beer
* we've already learned a lot
* this talk is technical
* we're gonna move fast
* there are no jokes, puns, or cats
* there are many visuals

---

## The Promise

I have done my best to organize this talk in such a way that everyone will learn something.

While this talk is technical and your attention is required, I try to take small steps so that everyone can follow along.

---

## The Bouncy Path

* Method Stack
* Recursion
* Trampolines
* Bonus
---

## Method Stack

---

### Stack Definition

Stacks in computing architectures are regions of memory where data is added or removed in a last-in-first-out (LIFO) manner.

https://en.wikipedia.org/wiki/Stack-based_memory_allocation

Stack actions:

* Push - adds to the top of the stack
* Pop - removes from the top of the stack

---

**Real World Example**

<img src="images/partial_stack_toy.jpg" alt="partial stack toy" height=600>

---

### ruby example
```ruby
class Person
  attr_reader :first_name, :last_name

  #... Person.new takes first and last name as params ...

  def full_name
    # sorry, I know this is not idiomatic ruby
    first_name.concat(' ').concat(last_name)
  end
end

person = Person.new("Nathan", "Hessler")

# What's happening when this gets run?
person.full_name
```

---
<!-- .slide: data-transition="none" -->
**Push full_name**

<img src="images/Hanoi_Tower_Set_1-01.svg" alt="push full_name" height=600>


---
<!-- .slide: data-transition="none" -->
**Push first_name**

<img src="images/Hanoi_Tower_Set_1-02.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop first_name**

<img src="images/Hanoi_Tower_Set_1-03.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push concat**

<img src="images/Hanoi_Tower_Set_1-04.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop concat**

<img src="images/Hanoi_Tower_Set_1-05.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push last_name**

<img src="images/Hanoi_Tower_Set_1-06.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop last_name**

<img src="images/Hanoi_Tower_Set_1-07.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push concat**

<img src="images/Hanoi_Tower_Set_1-08.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop concat**

<img src="images/Hanoi_Tower_Set_1-09.svg" alt="push full_name" height=600>

---

### Things To Know

* The Stack is not infinite
* What is our stack size?
  * We'll use 10
  * You can find your stack size if you want

```shell
  ulimit -s #=> 8192
```

---

## Recursion

---

### Definition

Recursion is the process a method goes through when one of the steps of the method involves invoking the method itself.

https://en.wikipedia.org/wiki/Recursion
---

### Factorial
**The Hello World of Recursion**

In mathematics, the factorial of a non-negative integer n, denoted by n!, is the product of all positive integers less than or equal to n.

https://en.wikipedia.org/wiki/Factorial

``` shell
3! =     3 * 2 * 1 = 6
4! = 4 * 3 * 2 * 1 = 24

# more formally (using recursion)

n! = n * (n-1)! when n > 1
n! = 1          when n = 0 or n = 1
```

---

### Recursive Factorial

```ruby
def factorial(n)
  return 1 if n <= 1
  n * factorial(n - 1)
end

# What happens when we run this?
factorial(3)
```

---
<!-- .slide: data-transition="none" -->
**Push factorial(3)**

<img src="images/Hanoi_Tower_Set_2-01.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial(2)**

<img src="images/Hanoi_Tower_Set_2-02.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial(1)**

<img src="images/Hanoi_Tower_Set_2-03.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial(1)**

<img src="images/Hanoi_Tower_Set_2-04.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial(2)**

<img src="images/Hanoi_Tower_Set_2-05.svg" alt="push full_name" height=600>

---

### Stackoverflow

* Remember:
  * The Stack is not infinite
  * Our stack size is 10
* Recursion is often what *'overflows'* the stack

``` ruby
# What happens when we run this?
factorial(11)
```

---

**The Stack Overfloweth**

<img src="images/Hanoi_Tower_Overflow3.svg" alt="push full_name" height=600>

---

### Tail Recursion

a tail call is a method call performed as the **final action** of a method. If a tail call leads to the same method being called again, the method is said to be **tail-recursive**,

https://en.wikipedia.org/wiki/Tail_call

---

### Tail Recursive Factorial

```ruby
def factorial(n) # maintain interface
  factorial_helper(1, n)
end

# never call directly
def factorial_helper(accumulator, n)
  return accumulator if n <= 1
  # make sure the last thing done is the recursive call
  factorial_helper(accumulator * n, n - 1)
end

#What happens when we run this?
factorial(3)
```
---
<!-- .slide: data-transition="none" -->
**Push factorial(3)**

<img src="images/Hanoi_Tower_Set_3-01.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(1, 3)**

<img src="images/Hanoi_Tower_Set_3-02.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(3, 2)**

<img src="images/Hanoi_Tower_Set_3-03.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(6, 1)**

<img src="images/Hanoi_Tower_Set_3-04.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(6, 1)**

<img src="images/Hanoi_Tower_Set_3-05.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(3, 2)**

<img src="images/Hanoi_Tower_Set_3-06.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(1, 3)**

<img src="images/Hanoi_Tower_Set_3-07.svg" alt="push full_name" height=600>

---

### Tail Call Elimination

Tail calls can be implemented without adding a new stack frame to the method stack. Most of the frame of the current method is not needed any more, and it can be replaced by the frame of the tail call, modified as appropriate.

https://en.wikipedia.org/wiki/Tail_call

**Note**: This is usually implemented by functional Languages(Lisp, Erlang, Haskell), and not by OO Languages(Java, Python, Ruby???)

---
<!-- .slide: data-transition="none" -->
**Push factorial(3)**

<img src="images/Hanoi_Tower_Set_4-01.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(1, 3)**

<img src="images/Hanoi_Tower_Set_4-02.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(1,3) and Push factorial_helper(3, 2)**

<img src="images/Hanoi_Tower_Set_4-03.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(3, 2) and Push factorial_helper(6, 1)**

<img src="images/Hanoi_Tower_Set_4-04.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(6, 1)**

<img src="images/Hanoi_Tower_Set_4-05.svg" alt="push full_name" height=600>

---

### Ruby and Tail Call Elimination

* A Muggle's Guide To Tail Call Optimization
* http://rubyconf.org/program#prop_1447
* Summary: Ruby has it
  * Not turned on by default
  * A bit finicky. Rails test fails with it on.

---

## Trampolines

---

### Insipiration: Clojure

* Clojure is a lisp dialect built on the Java VM
* Java is OO and the VM does not do tail call elimination
* Clojure is functional and really wants it
* `recur` is their solution

```clojure
(defn factorial [n]
  (factorial-helper 1 n)))

(defn factorial-helper [acc cnt]
  (if (zero? cnt)
    acc
    (recur (dec cnt) (* acc cnt)))))
```

---

### How does this work?

* There are a couple possibilities..
* They could be messing with the AST, it's Lisp after all
* They could just be doing some stack management tricks
* All are options in ruby
* we'll focus on stack management tricks

---

### Recurring Factorial

```ruby
def factorial(n) # maintain interface
  factorial_helper(1, n)
end

# never call directly
def factorial_helper(accumulator, n)
  return accumulator if n <= 1
  # replace tail call with recur method call
  recur(accumulator * n, n - 1)
end

```

---

### Recur Defined

```ruby
def recur(*args)
  return [:recur, args] if instance_variable_defined? :@caller
  begin
    @caller = binding.of_caller(1).eval('__method__')
    caller_args = [:start, args]
    loop do
      caller_args = __send__ @caller, *caller_args.last
      return caller_args unless caller_args.respond_to? :first
      return caller_args unless caller_args.first == :recur
    end
  ensure
    remove_instance_variable :@caller if instance_variable_defined? :@caller
  end
end
```

---

### 3 Phases to Recur

---

### Phase 1: Setup

* setup trampoline
* start trampoline loop
* "recur"

```ruby
def recur(*args)
# return [:recur, args] if instance_variable_defined? :@caller
  begin
    @caller = binding.of_caller(1).eval('__method__')
    caller_args = [:start, args]
    loop do
      caller_args = __send__ @caller, *caller_args.last
#     return caller_args unless caller_args.respond_to? :first
#     return caller_args unless caller_args.first == :recur
    end
# ensure
#   remove_instance_variable :@caller if instance_variable_defined? :@caller
  end
end
```

---

### Phase 2: Bounce
* add state management args to arg list and return
* short curcuit the recursive call
* allows the stack to pop to the first recur call

```ruby
def recur(*args)
  return [:recur, args] if instance_variable_defined? :@caller
# begin
#   @caller = binding.of_caller(1).eval('__method__')
#   caller_args = [:start, args]
#   loop do
#     caller_args = __send__ @caller, *caller_args.last
#     return caller_args unless caller_args.respond_to? :first
#     return caller_args unless caller_args.first == :recur
#   end
# ensure
#   remove_instance_variable :@caller if instance_variable_defined? :@caller
# end
end
```

---

### Phase 3: Cleanup
* Never gets to recur
* return results from loop
* clean up management args

```ruby
def recur(*args)
# return [:recur, args] if instance_variable_defined? :@caller
# begin
#   @caller = binding.of_caller(1).eval('__method__')
#   caller_args = [:start, args]
#   loop do
#     caller_args = __send__ @caller, *caller_args.last
      return caller_args unless caller_args.respond_to? :first
      return caller_args unless caller_args.first == :recur
#   end
  ensure
    remove_instance_variable :@caller if instance_variable_defined? :@caller
  end
end
```

---

**Will The Stack Overflow?**

``` ruby
# What happens when we run this?
factorial(11)
```

---
<!-- .slide: data-transition="none" -->
**Push factorial(11)**

<img src="images/Hanoi_Tower_Set_5_Final-01.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(1, 11)**

<img src="images/Hanoi_Tower_Set_5_Final-02.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push recur(11, 10)** *(setup)*

<img src="images/Hanoi_Tower_Set_5_Final-03.svg" alt="push full_name" height=600>

---

### Phase 1: Setup

```ruby
def recur(*args)
# return [:recur, args] if instance_variable_defined? :@caller
  begin
    @caller = binding.of_caller(1).eval('__method__')
    caller_args = [:start, args]
    loop do
      caller_args = __send__ @caller, *caller_args.last
#     return caller_args unless caller_args.respond_to? :first
#     return caller_args unless caller_args.first == :recur
    end
# ensure
#   remove_instance_variable :@caller if instance_variable_defined? :@caller
  end
end
```

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(11, 10)**

<img src="images/Hanoi_Tower_Set_5_Final-04.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push recur(110, 9)** *(bounce)*

<img src="images/Hanoi_Tower_Set_5_Final-05.svg" alt="push full_name" height=600>

---

### Phase 2: Bounce

```ruby
def recur(*args)
  return [:recur, args] if instance_variable_defined? :@caller
# begin
#   @caller = binding.of_caller(1).eval('__method__')
#   caller_args = [:start, args]
#   loop do
#     caller_args = __send__ @caller, *caller_args.last
#     return caller_args unless caller_args.respond_to? :first
#     return caller_args unless caller_args.first == :recur
#   end
# ensure
#   remove_instance_variable :@caller if instance_variable_defined? :@caller
# end
end
```

---
<!-- .slide: data-transition="none" -->
**Pop recur(110, 9)** *(bounce)*

<img src="images/Hanoi_Tower_Set_5_Final-06.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(10, 11)**

<img src="images/Hanoi_Tower_Set_5_Final-07.svg" alt="push full_name" height=600>

---

### Phase 3: Cleanup Maybe?

```ruby
def recur(*args)
# return [:recur, args] if instance_variable_defined? :@caller
# begin
#   @caller = binding.of_caller(1).eval('__method__')
#   caller_args = [:start, args]
    loop do
      caller_args = __send__ @caller, *caller_args.last
      return caller_args unless caller_args.respond_to? :first
      return caller_args unless caller_args.first == :recur
    end
# ensure
#   remove_instance_variable :@caller if instance_variable_defined? :@caller
# end
end

```

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(110, 9)**

<img src="images/Hanoi_Tower_Set_5_Final-08.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push recur(990, 8)** *(bounce)*

<img src="images/Hanoi_Tower_Set_5_Final-09.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop recur(990, 8)** *(bounce)*

<img src="images/Hanoi_Tower_Set_5_Final-10.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(110, 9)**

<img src="images/Hanoi_Tower_Set_5_Final-11.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(990, 8)**

<img src="images/Hanoi_Tower_Set_5_Final-12.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push recur(7920, 7)** *(bounce)*

<img src="images/Hanoi_Tower_Set_5_Final-13.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop recur(7920, 7)** *(bounce)*

<img src="images/Hanoi_Tower_Set_5_Final-14.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(990, 8)**

<img src="images/Hanoi_Tower_Set_5_Final-15.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push factorial_helper(7920, 7)**

<img src="images/Hanoi_Tower_Set_5_Final-16.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Push recur(55440, 6)**

<img src="images/Hanoi_Tower_Set_5_Final-17.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop recur(55440, 6)**

<img src="images/Hanoi_Tower_Set_5_Final-18.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**Pop factorial_helper(7920, 7)**

<img src="images/Hanoi_Tower_Set_5_Final-19.svg" alt="push full_name" height=600>

---

### Lets move a bit faster
**Can you see the bouncing up and down the stack?**

---
<!-- .slide: data-transition="none" -->
**factorial_helper does some work, recur catches**

<img src="images/Hanoi_Tower_Set_5_Final-20.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**and we bounce back down**

<img src="images/Hanoi_Tower_Set_5_Final-21.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**factorial_helper does some work, recur catches**

<img src="images/Hanoi_Tower_Set_5_Final-22.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**and we bounce back down**

<img src="images/Hanoi_Tower_Set_5_Final-23.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**factorial_helper does some work, recur catches**

<img src="images/Hanoi_Tower_Set_5_Final-24.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**and we bounce back down**

<img src="images/Hanoi_Tower_Set_5_Final-25.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**factorial_helper does some work, recur catches**

<img src="images/Hanoi_Tower_Set_5_Final-26.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**and we bounce back down**

<img src="images/Hanoi_Tower_Set_5_Final-27.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**factorial_helper does some work, recur catches**

<img src="images/Hanoi_Tower_Set_5_Final-28.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**and we bounce back down**

<img src="images/Hanoi_Tower_Set_5_Final-29.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**factorial_helper does some work**

<img src="images/Hanoi_Tower_Set_5_Final-30.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**and we bounce back down**

<img src="images/Hanoi_Tower_Set_5_Final-31.svg" alt="push full_name" height=600>

---

### Phase 3: Cleanup

```ruby
def recur(*args)
# return [:recur, args] if instance_variable_defined? :@caller
  begin
#   @caller = binding.of_caller(1).eval('__method__')
#   caller_args = [:start, args]
#   loop do
#     caller_args = __send__ @caller, *caller_args.last
      return caller_args unless caller_args.respond_to? :first
      return caller_args unless caller_args.first == :recur
#   end
  ensure
    remove_instance_variable :@caller if instance_variable_defined? :@caller
  end
end

```

---
<!-- .slide: data-transition="none" -->
**We're Done, return the result**

<img src="images/Hanoi_Tower_Set_5_Final-32.svg" alt="push full_name" height=600>

---
<!-- .slide: data-transition="none" -->
**We Did It! We Beat The Stack!**

<img src="images/Hanoi_Tower_Set_5_Final-33.svg" alt="push full_name" height=600>

---

### Torc Gem 0.2.0
##### Tail Optimized Recursive Caller

* The code we just reviewed was 0.1.0
* 0.2.0 added guards against collisions
* and some new tail call optimization techniques
* Possible Cool things coming in 0.3.0
  * guards against non tail-recursive methods
  * real functional trampolines
  * write your tail-recursive method normally
* Probably not production worthy. Use at own risk
* and really, you could and probably should just use a loop

---

### Thank You!
##### please hold applause

**Nathan Hessler**

* twitter: @spune
* github: nhessler
* work: customink
* meetup: NoVA Code & Coffee

---

**Shout Outs**

* Josh Cheek
* Sean McBeth
* Reginald Braithwaite (raganwald)
* Kat Hubbs

---

## Bonus

---

### Real Trampolines
##### the functional pattern

``` ruby
def trampoline(meth)
  lambda do |*args|
    thunk = meth.call(*args)
    loop do
      return thunk unless thunk.is_a? Proc
      thunk = thunk.call()
    end
  end
end
```

---

### Trampolined Factorial
``` ruby
def factorial(n)
  trampoline(method(:factorial_helper)).call(1, n)
end

def factorial_helper(acc, n)
  return acc if n <= 1
  lambda { factorial_helper(acc * n, n - 1) }
end

# What happens when we run this?
# Try working it out with what we've learned
factorial(11) #=> 39_916_800
```

---
## The End

#### You can clap now if you like

**beer summit**

I will be there. happy to talk or answer questions.

> This is slide 100! hopefully I finished on time
