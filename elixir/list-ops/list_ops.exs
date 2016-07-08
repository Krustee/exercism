defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end
  defp do_count([], count), do: count
  defp do_count([_head | tail], count) do
    do_count(tail, count + 1)
  end
  
  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end
  defp do_reverse([], reversed), do: reversed
  defp do_reverse([head | tail], reversed) do
    do_reverse(tail, [head | reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end
  defp do_map([], _f, acc), do: reverse(acc)
  defp do_map([head | tail], f, acc) do
    do_map(tail, f, [f.(head) | acc])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end
  defp do_filter([], _, acc), do: reverse(acc)
  defp do_filter([head | tail], f, acc) do
    case f.(head) do
      true -> 
        do_filter(tail, f, [ head | acc])
      false ->
        do_filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, acc, f)
  end
  defp do_reduce([], acc, _f), do: acc
  defp do_reduce([head | tail], acc, f) do
    do_reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    do_append(a, b, [])
  end
  defp do_append([], [], acc), do: reverse(acc)
  defp do_append([], [head | tail], acc) do
    do_append([], tail, [head | acc])
  end
  defp do_append([head | tail], b, acc) do
    do_append(tail, b, [head | acc])
  end
  
  @spec concat([[any]]) :: [any]
  def concat(ll) do
    for list <- ll, elem <- list, do: elem
  end
  
end
