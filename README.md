# calculi

A WIP collection of various calculi implementations and their semantics.

Not all calculi will have lexers and parsers, some may only exist as a Haskell ADT.


## Lambda Untyped

Untyped lambda calculus.

To run an example

    $ make
    $ cat example/LambdaUntyped/if.lu
    ((\id.
        (if (id true) unit false))
     (\x.x))
    $ stack exec LambdaUntyped examples/LambdaUntyped/if.lu
    "Unit"


## Lambda Assignment

Untyped lambda calculus with assignment.

To run an example

    $ make
    $ cat examples/LambdaAssignment/sequencing.la
    ((\seq.((\x.((seq ((seq (write x false))
                            (write x true)))
                      (read x)))
            (new unit)))
     (\ignore.(\a.a)))
    $ stack exec LambdaAssignment examples/LambdaAssignment/sequencing.la
    "ExpTrue"


## Lambda Simply Typed

WIP Simply typed lambda calculus.

Currently lacks type checking and semantic specification.

To run an example

    $ make
    $ cat examples/LambdaSimplyTyped/if.lt
    ((\id:Bool->Bool.
        (if (id true) unit false))
     (\x:Bool.x))
    $ stack exec LambdaSimplyTyped examples/LambdaSimplyTyped/if.lt
    "Unit"


## Running the tests

To run the unit tests:

    $ make test


## Viewing the semantics

To build and view the semantics for a given calculi

    $ cd docs/LambdaAssignment
    $ make view

