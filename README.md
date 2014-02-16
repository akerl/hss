hss
=========

[![Gem Version](https://badge.fury.io/rb/hss.png)](http://badge.fury.io/rb/hss)
[![Dependency Status](https://gemnasium.com/akerl/hss.png)](https://gemnasium.com/akerl/hss)
[![Code Climate](https://codeclimate.com/github/akerl/hss.png)](https://codeclimate.com/github/akerl/hss)
[![Coverage Status](https://coveralls.io/repos/akerl/hss/badge.png)](https://coveralls.io/r/akerl/hss)
[![Build Status](https://travis-ci.org/akerl/hss.png?branch=master)](https://travis-ci.org/akerl/hss)
[![MIT Licensed](http://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

SSH helper that uses regex and fancy expansion to dynamically manage SSH shortcuts

## Installation

```
gem install hss
ln -s /path/to/your/config.yml ~/.hss.yml
```

### SCP usage

This script can be used by SCP and other things that use SSH as a transport. To use it with SCP, just specify hss for the -S flag:

```
scp -S hss host:files/ other_host:location/
```

You can alias this for the greater good:

```
alias pcs='scp -S hss'
```

## Configuration

1. You can put your configuration in ~/.hss.yml or another file specified by the "HSS\_CONFIG" environment variable.
2. The only required configuration section is "patterns", which contains an array of hashes with the following attributes:
  * note: Name of this pattern ("my servers")
  * example: Shows how this is used ("jimbo -> root@jimbo.example.org")
  * short: Regex for shortcut ("^(jimbo|bob|chuck)$")
    * Use matching to collect things you want to use in the expanded form
  * long: Expanded form of this shortcut ("root@#$1.example.org")
    * This will be evaluated using Ruby's string interpolation, so you can use "#{var}", "#$1", "#{function()}", etc.
3. Helpers are available for use in long forms
  * expand(x): Uses the "expansions" section of the config. Format for this section is a hash of lists, as such:

```
expansions:
    expanded_form:
        - short_form1
        - short_form2
        - shrtfrm3
```

  * shortcut(x): Uses the "shortcuts" section of the config. Format for this section is a hash of strings, as such

```
shortcuts:
    short1: expand to this
    other_short: 'expand to something else!'
```

  * command(x): Runs the given string as a command and uses the output for the expanded form
  * default(x, y): If x is not nil, uses x. If it's nil, use y
  * external(source, key): Loads source as a YAML file and looks for the given key. The YAML should be made of hashes (you can nest them) and the key should be dot-separated:

```
fish:
    color: blue # accessible with key = 'fish.color'
    alpha:
        dog: sparky
        cat: grouchy # accessible with key 'fish.alpha.cat'
```

## Usage

1. Run `hss help` for a list of available commands
2. Run `hss $command` to do that thing

## Falling back to another command

If you define the environment variable "HSS_PASS", hss will fall back to that command if it fails to find a match:

```
# export HSS_PASS='ssh'

# hss git@github.com
PTY allocation request failed on channel 0
Hi akerl! You've successfully authenticated, but GitHub does not provide shell access.
Connection to github.com closed.
```

## Debugging

If you want hss to print the command it would have run rather than executing it, you just need to set the HSS\_DEBUG environment variable to something:

```
export HSS_DEBUG=foo
hss bar # will print rather than exec
```

## License

hss is released under the MIT License. See the bundled LICENSE file for details.

