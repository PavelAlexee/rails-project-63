# HexletCode


[![Ruby CI](https://github.com/PavelAlexee/rails-project-63/actions/workflows/ci.yml/badge.svg)](https://github.com/PavelAlexee/rails-project-63/actions/workflows/ci.yml)
[![Hexlet Check](https://github.com/PavelAlexee/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/PavelAlexee/rails-project-63/actions/workflows/hexlet-check.yml)

DSL form generator gem for Hexlet project.


## Installation

Install the gem and add to the application's Gemfile by executing:


```bash
bundle add hexlet_code
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install hexlet_code
```

## Usage

```bash
require 'hexlet_code'

# Define your user model
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

# Generate a form with inputs
form = HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end

puts form
```

### Output:

```bash
html
<form action="#" method="post"><input name="name" type="text" value="rob"><textarea name="job" cols="20" rows="40">hexlet</textarea></form>
```

```bash
form = HexletCode.form_for user do |f|
  f.input :job, as: :text, rows: 50, cols: 50
end
```


### Output:

```bash
html
<form action="#" method="post"><textarea name="job" cols="50" rows="50">hexlet</textarea></form>
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HexletCode project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).
