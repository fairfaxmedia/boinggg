# boinggg

Tool for executing simple test suites for HTTP redirects.

## Installation

    $ gem install boinggg

## Defining tests

    ---
    simple:
      - "301 http://merry.com/ https://www.merry.com/"
      - "301 http://pippin.com/ https://www.pippin.com/"
      - "302 http://www.theshire.org/ http://www.theshire.org/beerfestival/"
    # this syntax isn't implemented yet; documenting it here as a guide
    # for future implementation
    foo_to_bar:
      fqdns:
        - merry.com
        - pippin.com
        - www.merry.com
        - www.pippin.com
      from: /foo
      to: /bar
      type: 301

## Running tests

    boinggg run_tests testsuite.yaml server.domain 80

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

