# Tutorial

## First steps

## Learning Blodwen

This is an overview of the atom package for Blodwen. If you are interested in learning Blodwen you can find the [official documentation](http://docs.blodwen-lang.org/en/latest/), and the [official Blodwen tutorial](http://docs.blodwen-lang.org/en/latest/tutorial/).

### Installation

Install the `language-blodwen` package from the atom settings.
The package might tell you that you need to set the path to the `blodwen` executable
in the settings.

Create a new file and call it `ops.blod`.
Paste this code into your new file:

```blodwen
module Ops

||| Add two natural numbers.
add : Nat -> Nat -> Nat
add Z     y = y
add (S k) y = S (add k y)

||| Multiply two natural numbers.
mul : Nat -> Nat -> Nat
mul Z     y = Z
mul (S k) y = add y (mul k y)
```

### Typecheck

Open the command palette (`ctrl-shift-p` on Win/Linux) and select `Language Blodwen: Typecheck`. (or use `ctrl-alt-r`)

### Type info

Select an instance of the `add` function in your code and press `ctrl-alt-t` or use the command palette (`ctrl-shift-p` on Win/Linux) and search for "Language Blodwen: Type Of". A panel should open at the bottom of your window showing you the type of the `add` function, `Ops.add : Nat -> Nat -> Nat`.
Now try the same thing with the `mul` function.

### Show documentation

Another useful command is triggered by selecting a word and pressing `ctrl-alt-d` (or "Language Blodwen: Docs for" from the command palette). You can try it on `add`, `mul` or `Nat` for instance.

### REPL

You can create a REPL window by pressing `ctrl-alt-enter`. Enter REPL commands at the top, just as if you were using the REPL command line interface. 

### Blodwen command line options and library package dependencies 

Sometimes you may have dependendencies on Blodwen packages, for instance Lightyear for parsing or Pruvioj for advanced theorem proving. 
In Atom you can specify these dependencies using the project model, which simply means using Open Folder rather than Open File 
from the File menu. Atom will look for a .ipkg file in the folder and load any dependencies listed. More details are described in 
[Working with ipkg files](https://github.com/blodwen-hackers/atom-language-blodwen/blob/master/documentation/ipkg.md). 

## Interactive proofs using Blodwen and Atom

We'll try to prove that the addition of natural numbers is associative for the
purpose of this tutorial.

Create a new file, call it `proving.blod` and insert the following code into it.

```blodwen
module Main

plusAssoc : (l, c, r : Nat) -> l `plus` (c `plus` r) = (l `plus` c) `plus` r
```

Load the file into Blodwen by typechecking it by pressing `ctrl-alt-r`. Then press `ctrl-shift-p` and type "Language Blodwen: Holes".

At the bottom of your window should open a small panel with all holes you'll have to prove.
Here it should just show:
```
Main.plusAssoc
    l : Nat
    c : Nat
    r : Nat
------------------------------------------------------
Main.plusAssoc : plus l (plus c r) = plus (plus l c) r
```
where `l : Nat, c : Nat, r : Nat` are variables you can use to prove
`Main.plusAssoc : plus l (plus c r) = plus (plus l c) r`.

If you put your cursor over `plusAssoc` in the `proving.blod` file and execute the command "Language Blodwen: Add Clause" (`ctrl-alt-a`) a line wil be inserted by atom at the bottom of your file.

Your file should now look like this:
```blodwen
module Main

plusAssoc : (l, c, r : Nat) -> l `plus` (c `plus` r) = (l `plus` c) `plus` r
plusAssoc l c r = ?plusAssoc_rhs
```

If you select the `l` in `plusAssoc l c r = ?plusAssoc_rhs` and press `ctrl-alt-c` ("Language Blodwen: Case Split") it splits the `Nat` at `l`
into it's two cases `Z` (zero) and `(S k)` (the successor of `k`).
Rename `k` to `l` as we had it before, to show that it is the left value.

Your file should now look like this:
```blodwen
module Main

plusAssoc : (l, c, r : Nat) -> l `plus` (c `plus` r) = (l `plus` c) `plus` r
plusAssoc Z c r = ?plusAssoc_rhs_1
plusAssoc (S l) c r = ?plusAssoc_rhs_2
```

After type checking the file again, open the holes view and it will show you both holes:

```
Main.plusAssoc_rhs_1
    c : Nat
    r : Nat
------------------------------------------
Main.plusAssoc_rhs_1 : plus c r = plus c r

Main.plusAssoc_rhs_2
    l : Nat
    c : Nat
    r : Nat
--------------------------------------------------------------------
Main.plusAssoc_rhs_2 : S (plus l (plus c r)) = S (plus (plus l c) r)
```

Now you can see, that you need to prove that `plus c r = plus c r` for `Main.plusAssoc_rhs_1`. Blodwen can insert the code automatically for us. Select `plusAssoc_rhs_1` and press `ctrl+alt+s` ("Language Blodwen: Proof Search") and Blodwen will insert `Refl` for you.

Now the file looks like this:
```blodwen
module Main

plusAssoc : (l, c, r : Nat) -> l `plus` (c `plus` r) = (l `plus` c) `plus` r
plusAssoc Z c r = Refl
plusAssoc (S l) c r = ?plusAssoc_rhs_2
```

Only one hole is left now:

```
Main.plusAssoc_rhs_2
    l : Nat
    c : Nat
    r : Nat
--------------------------------------------------------------------
Main.plusAssoc_rhs_2 : S (plus l (plus c r)) = S (plus (plus l c) r)
```

Now replace the line

```blodwen
plusAssoc (S l) c r = ?plusAssoc_rhs_2
```

with

```blodwen
plusAssoc (S l) c r = rewrite plusAssoc l c r in ?plusAssoc_rhs_2
```

and after type checking the holes view now shows us:

```
Main.plusAssoc_rhs_2
    l : Nat
    c : Nat
    r : Nat
    _rewrite_rule : plus (plus l c) r = plus l (plus c r)
--------------------------------------------------------------------
Main.plusAssoc_rhs_2 : S (plus (plus l c) r) = S (plus (plus l c) r)
```

Now you need to prove that `S (plus (plus l c) r) = S (plus (plus l c) r)` and Blodwen can again do this for us.

And you end with the file

```blodwen
module Main

plusAssoc : (l, c, r : Nat) -> l `plus` (c `plus` r) = (l `plus` c) `plus` r
plusAssoc Z c r = Refl
plusAssoc (S l) c r = rewrite plusAssoc l c r in Refl
```

and a proof that the addition of natural numbers is associative.

This tutorial is a written version of [David Christiansen's](https://twitter.com/d_christiansen) emacs video for Atom.
https://www.youtube.com/watch?v=0eOY1NxbZHo&list=PLiHLLF-foEexGJu1a0WH_llkQ2gOKqipg
