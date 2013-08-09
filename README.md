hss
=========

SSH helper that uses regex and fancy expansion to dynamically manage SSH shortcuts

## Usage

1. Install as per the Installation section below
2. Set your configuration yaml up as desired
3. Run `./hss.rb help` for a list of available commands
4. Run `./hss.rb $command` to do that thing

## Configuration

1. You can put your configuration in ~/.hss.yml, ./config.yml (same directory as hss.rb), or another file specified by the "HSS\_CONFIG" environment variable.
2. The only required configuration section is "patterns", which contains an array of hashes with the following attributes:
  * note: Name of this pattern ("my servers")
  * example: Shows how this is used ("jimbo -> root@jimbo.example.org")
  * short: Regex for shortcut ("^(jimbo|bob|chuck)$")
    * Use matching to collect things you want to use in the expanded form
  * long: Expanded form of this shortcut ("root@#$1.example.org")
    * This will be evaluated using Ruby's string interpolation, so you can use "#{var}", "#$1", "#{function()}", etc.
3. Other helpers are available for use in long forms
  * expand(): Uses the "expansions" section of the comfig. Format for this section is a hash of lists, as such
    expansions:
        expanded_form:
            - short_form1
            - short_form2
            - shrtfrm3
  * shortcut(): Uses the "shortcuts" section of the config. Format for this section is a hash of strings, as such
    shortcuts:
        short1: expand to this
        other_short: 'expand to something else!'
  * command(): Runs the given string as a command and uses the output for the expanded form

## Installation

    git clone git://github.com/akerl/hss
    Drop your desired configuration yaml into ./config.yml or ~/.hss.yml, or set HSS_CONFIG to the desired path in your ENV
    For convenience, you can symlink hss.rb into /usr/local/bin or somewhere else in your $PATH

## License

hss is released under the MIT License. See the bundled LICENSE file for details.

