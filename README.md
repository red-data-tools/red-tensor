# Tensor - Common protocol for numerical array libraries

Tensor provides the programming interface and the backend protocol for operating numerical arrays among different libraries.

## Install

```console
$ gem install red-tensor
```

## Usage

```ruby
require "tensor"
require "numo/narray"
require "pandas"

x1  = [0, 0.5, 1, 1.5, 2].map {|x| x * Math::PI }
x2 = Numo::DFloat[*ary]
x3 = Pandas::Series.new(a)

y1 = Tensor.sin(x1)
y2 = Tensor.sin(x2)
y3 = Tensor.sin(x3)

p y1.class  #=> Array
p y2.class  #=> Numo::DFloat
p y3.class  #=> <class 'pandas.core.series.Series'>
```

## License

MIT License

## Author

- [Kenta Murata](https://github.com/mrkn)
