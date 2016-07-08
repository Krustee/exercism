defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    do_encode(string)
  end

  defp do_encode(<< >>), do: ""
  defp do_encode(<< c::utf8, rest::binary >>) do
    do_encode(rest, %{:current_run => c, :count => 1, :output => ""})
  end 
  defp do_encode(<< c::utf8, rest::binary >>, %{:current_run => current, :count => count, :output => output} = acc) do
    if current === c do
      do_encode(rest, Map.put(acc, :count, acc.count + 1))
    else
      do_encode(rest, %{:current_run => c, :count => 1, :output => output <> to_string(count) <> utf_char_to_string(current)})
    end
  end
  defp do_encode("", %{count: count, current_run: current, output: output}) do
    output <> to_string(count) <> utf_char_to_string(current)
  end
  
  defp utf_char_to_string(value) do
    to_string([value])
  end
  
  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r{(\d+)(\D+)}u, string)
    |> Enum.reduce("", fn([_matched, count, letter], accStr) -> 
        accStr <> String.duplicate(letter, String.to_integer(count))
      end)
  end
end
