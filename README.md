# Gobble

The **gobble** utility eats a dictionary and spits out the remains. It generates two output files, _sequences_ and _words_. The _sequences_ file contains every sequence of four letters (A-z) that appears in exactly one word of the dictionary, one sequence per line. The _words_ file contains the corresponding words that contain the sequences, in the same order, one word per line.

A Ruby solution to the [Words Test](https://gist.github.com/pedromartinez/7788650).

## Installation

    $ gem install specific_install
    $ gem specific_install endersstocker/gobbler

## Usage

<pre>
<b>gobble</b> [<b>-i</b>] <u>dictionary</u>
</pre>

The following option is available:

`-i, --ignore-case` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Perform case insensitive matching. By default, gobble is case sensitive.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
