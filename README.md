hss
=========

SSH helper that uses regex and fancy expansion to dynamically manage SSH shortcuts

## Usage

1. Install as per the Installation section below
2. Set your configuration yaml up as desired (more details on doing so in future updates)
3. Run `./hss.rb help` for a list of available commands
4. Run `./hss.rb $command` to do that thing

## Installation

    git clone git://github.com/akerl/hss
    Drop your desired configuration yaml into ./config.yml or ~/.hss.yml, or set HSS_CONFIG to the desired path in your ENV
    For convenience, you can symlink hss.rb into /usr/local/bin or somewhere else in your $PATH

## License

hss is released under the MIT License. See the bundled LICENSE file for details.

