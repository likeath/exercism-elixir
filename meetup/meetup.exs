defmodule Meetup do
  alias Meetup.CalendarData
  @teenth_days 13..19

  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    {year, month}
    |> CalendarData.for_month
    |> Map.get(weekday)
    |> get_day(schedule)
    |> form_result(year, month)
  end

  defp get_day(days, :first),  do: List.first(days)
  defp get_day(days, :second), do: Enum.at(days, 1)
  defp get_day(days, :third),  do: Enum.at(days, 2)
  defp get_day(days, :fourth), do: Enum.at(days, 3)
  defp get_day(days, :last),   do: List.last(days)
  defp get_day(days, :teenth), do: Enum.find(days, &(&1 in @teenth_days))

  defp form_result(day, year, month), do: {year, month, day}


  defmodule CalendarData do
    @days [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

    def for_month(date = {_year, _month}) do
      date
      |> month_boundary
      |> group_by_weekdays(date)
    end

    defp month_boundary({year, month}) do
      1..:calendar.last_day_of_the_month(year, month)
    end

    defp group_by_weekdays(days, {year, month}) do
      days
      |> Enum.reduce(%{}, fn day, result ->
        Map.merge(
          result,
          %{ day_title({year, month, day}) => [day] },
          fn (_, days_before, days_after) -> days_before ++ days_after end
        )
      end)
    end

    defp day_title(date) do
      day_num = :calendar.day_of_the_week(date)
      Enum.at(@days, day_num - 1)
    end
  end
end
