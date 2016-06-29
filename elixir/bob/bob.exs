defmodule Bob do
  def hey(input) do
    strippedMsg = input |> String.strip;
    shouting = String.upcase(strippedMsg) == input && String.downcase(strippedMsg) != input;
    empty = strippedMsg == "";
    question = String.last(strippedMsg) == "?";
    cond do
      empty ->
        "Fine. Be that way!"
      question ->
        "Sure."
      shouting ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end
