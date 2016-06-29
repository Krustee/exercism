defmodule Words do
  
  @punctuation ~r/[^\w\s-]/u
  @space_or_underscore ~r{[\s_]}
  
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    String.downcase(sentence)
    |> String.split(@space_or_underscore, trim: true)
    |> Enum.map(&(String.replace(&1, @punctuation, "")))
    |> Enum.reduce(%{}, fn word, map -> update_word_count(word, map) end)
    |> Map.delete("")
  end
  
  defp update_word_count(word, map) do
    Map.update(map, word, 1, &(&1 + 1)) 
  end
end
