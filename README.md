[![Build Status](https://travis-ci.org/gary/calc.svg?branch=master)](https://travis-ci.org/gary/calc)
[![Maintainability](https://api.codeclimate.com/v1/badges/2563372ab01f0639399e/maintainability)](https://codeclimate.com/github/gary/calc/maintainability)
[![Inline docs](http://inch-ci.org/github/gary/calc.svg?branch=master)](http://inch-ci.org/github/gary/calc)

# Calc

This simple Reverse Polish Notation (RPN) Calculator is built to be composable. It is a command-line program that (as of this writing) has the following features:

* Ability to do basic arithmetic: [Addition](https://github.com/gary/calc/blob/108ae23/lib/calc/operations.rb#L9), [subtraction](https://github.com/gary/calc/blob/108ae23/lib/calc/operations.rb#L14-L15), [multiplication](https://github.com/gary/calc/blob/108ae23/lib/calc/operations.rb#L10-L12), and [division](https://github.com/gary/calc/blob/108ae23/lib/calc/operations.rb#L13)

* Ability to operate in console mode or take input by file

* Support for a quit command (via `q`) in addition to EOF (or `Ctrl-D`)

* Graceful recovery from input errors such as invalid operations (e.g., trying to perform addition with only 1 operand)

## Installation

Install it locally like so:

    $ hub clone gary/calc
    $ cd calc
    $ rake install:local

## Usage

After installing it, invoke it as follows:

    $ calc [optional-file]

## Example Output

```
$ calc
> 4
4
> 3.75
3.75
> *
15
> 2
2
> /
7.5
> q
```

## Architectural Highlights:

* No runtime dependencies

* Classes abide by the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle)

* All components (except the [`Main`](https://github.com/gary/calc/blob/108ae23/lib/calc/main.rb)) strive to be loosely coupled and highly reusable

* Public interfaces for all classes have:

   - Distinct earmarks via YARD's [`@api`](http://www.rubydoc.info/gems/yard/file/docs/Tags.md#api) tag

   - Documentation of inputs, outputs, exceptions raised, and return values

   - Maintenance friendly signatures (i.e., exclusive use of keyword arguments)

* All member variables accessed through `attr_` macros to show intent and are grouped at the top of each class declaration

* [`Calculator`](https://github.com/gary/calc/blob/108ae23/lib/calc/calculator.rb) is built to be composable: New operations can be added with ease

* [`Interface`](https://github.com/gary/calc/blob/108ae23/lib/calc/interface.rb) is also built with extension to new, IO-like interfaces in mind

## Hindsight

If I was to spend more time on this project, I would do two things:

* *Mutation test it.* I feel that I did a thorough job of designing my components to minimize surprise and control user input to provide a good user experience, but I human. [Mutation testing](https://github.com/backus/mutant) can find additional code that is either not covered or does not have a specced side effect. Maybe next time.

* *Make its output less "echo-ey".* While I do feel that the output is intelligible, I believe it could be improved to, say, only return either the sole operand (in the case of single item, non-sign input) or the result of an operation (in the case of a multi-item input that could be a complex calculation).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gary/calc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

