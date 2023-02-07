defmodule HeapTest do
  use ExUnit.Case
  alias Heap

  test "pushing works right" do
    heap =
      Heap.new()
      |> Heap.push(3)
      |> Heap.push(2)
      |> Heap.push(-1)

    assert heap.value == -1

    heap =
      Heap.new()
      |> Heap.push(100)
      |> Heap.push(-100)
      |> Heap.push(-200)
      |> Heap.push(300)
      |> Heap.push(-300)
      |> Heap.push(400)
      |> Heap.push(-400)
      |> Heap.push(500)

    assert heap.value == -400
  end

  test "popping works right" do
    heap =
      Heap.new()
      |> Heap.push(3)
      |> Heap.push(2)
      |> Heap.push(-1)
      |> Heap.pop()

    assert heap.value == 2

    heap =
      Heap.new()
      |> Heap.push(100)
      |> Heap.push(-100)
      |> Heap.push(-200)
      |> Heap.push(300)
      |> Heap.push(-300)
      |> Heap.push(400)
      |> Heap.push(-400)
      |> Heap.push(500)
      |> Heap.pop()

    assert heap.value == -300

    heap =
      Heap.new()
      |> Heap.push(100)
      |> Heap.push(-100)
      |> Heap.push(-200)
      |> Heap.push(300)
      |> Heap.push(-300)
      |> Heap.push(400)
      |> Heap.push(-400)
      |> Heap.push(500)
      |> Heap.pop()
      |> Heap.pop()
      |> Heap.pop()

    assert heap.value == -100
  end

  test "The real deal: Heap Sort works" do
    for _ <- 1..10000 do
      list = 1..100 |> Enum.map(fn _ -> Enum.random(-1000..1000) end)
      assert Enum.sort(list) == Heap.sort(list)
    end
  end
end
