defmodule Heap do
  defguard is_empty(heap) when heap.size == 0
  defguard is_leaf(heap) when heap.size == 1

  defguard next_leaf_on_left(heap) when (heap.size + 1) |> rem(2) == 0

  defstruct value: nil, left: nil, right: nil, size: 0

  @type t :: %__MODULE__{
          value: integer() | nil,
          left: t() | nil,
          right: t() | nil,
          size: integer()
        }

  @spec push(t() | nil, integer()) :: t()
  def push(%__MODULE__{value: nil}, value) do
    new(value)
  end

  def push(%__MODULE__{left: left, size: size} = heap, value) when next_leaf_on_left(heap) do
    %__MODULE__{
      heap
      | size: size + 1,
        left: push(left, value)
    }
    |> bubble_up()
  end

  def push(%__MODULE__{right: right, size: size} = heap, value) do
    %__MODULE__{
      heap
      | size: size + 1,
        right: push(right, value)
    }
    |> bubble_up()
  end

  def push(nil, value) do
    new(value)
  end

  def pop(nil) do
    nil
  end

  def pop(%__MODULE__{value: _value, size: _size, left: nil, right: nil}) do
    nil
  end

  # One of these two clauses will never execute. Which one? :3
  def pop(%__MODULE__{value: _value, size: _size, left: left, right: nil}) do
    left
  end

  def pop(%__MODULE__{value: _value, size: _size, left: nil, right: right}) do
    right
  end

  def pop(%__MODULE__{
        value: _value,
        size: size,
        left: %__MODULE__{value: left_value} = left,
        right: %__MODULE__{value: right_value} = right
      }) do
    if left_value < right_value do
      %__MODULE__{
        left
        | size: size - 1,
          left: pop(left),
          right: right
      }
    else
      %__MODULE__{
        right
        | size: size - 1,
          left: left,
          right: pop(right)
      }
    end
  end

  def sort(list) when is_list(list) do
    filled_heap = fill(list)
    drain(filled_heap)
  end

  def fill(list) when is_list(list) do
    fill_rec(list, new())
  end

  defp fill_rec([], heap) do
    heap
  end

  defp fill_rec([next | rest], heap) do
    fill_rec(rest, push(heap, next))
  end

  def drain(heap = %__MODULE__{}) do
    Enum.reverse(drain_rec(heap, []))
  end

  defp drain_rec(nil, acc) do
    acc
  end

  defp drain_rec(heap = %__MODULE__{value: value}, acc) do
    drain_rec(
      pop(heap),
      [value | acc]
    )
  end

  @spec bubble_up(t()) :: t()
  defp bubble_up(
         %__MODULE__{
           value: top_value,
           right: right = %__MODULE__{value: right_value}
         } = heap
       )
       when top_value > right_value do
    %__MODULE__{
      heap
      | value: right_value,
        right: %__MODULE__{right | value: top_value}
    }
  end

  defp bubble_up(
         heap = %__MODULE__{value: top_value, left: left = %__MODULE__{value: left_value}}
       )
       when top_value > left_value do
    %__MODULE__{
      heap
      | value: left_value,
        left: %__MODULE__{left | value: top_value}
    }
  end

  defp bubble_up(%__MODULE__{} = heap) do
    heap
  end

  @spec new() :: t()
  def new, do: %__MODULE__{}
  @spec new(integer()) :: t()
  def new(value), do: %__MODULE__{value: value, size: 1}
end
