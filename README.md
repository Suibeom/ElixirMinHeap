# Minheap

This repository is a quick reworking of the code from a blogpost about the heap datastructure I read

It was a fine blog post, but... The code was obviously and badly broken. So I decided, as an exercise, to fix it using test-driven development. This is the end result. But, as they say, the journey is the destination. My target was to write a big procedural test to show that heapsort could use this data structure successfully. I may make a bigger suite of tests and a separate branch that lets you relive it without spoilers. Enjoy!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `minheap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:minheap, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/minheap>.

