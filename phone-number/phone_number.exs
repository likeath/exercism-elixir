defmodule Phone do
  @separators_regex ~r/[\.\(\)\-\s+]/

  @valid_number_length 10
  @probably_valid_number_length 11

  @invalid_number String.duplicate("0", @valid_number_length)


  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> strip_separators
    |> normalize_number
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> number
    |> String.codepoints
    |> Enum.take(3)
    |> Enum.join
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
    |> number
    |> String.replace(~r/(\d{3})(\d{3})(\d{4})/, "(\\1) \\2-\\3")
  end

  defp strip_separators(number) do
    number
    |> String.replace(@separators_regex, "")
  end

  defp normalize_number(number) do
    cond do
      String.length(number) == @valid_number_length ->
        number
      String.length(number) == @probably_valid_number_length && String.starts_with?(number, "1") ->
        String.slice(number, 1, @valid_number_length)
      :else ->
        @invalid_number
    end
  end
end
