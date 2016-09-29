defmodule Garden do
  @plants %{
    "C" => :clover,
    "G" => :grass,
    "R" => :radishes,
    "V" => :violets
  }

  @default_student_names ~w(
    alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry
  )a

  @plants_count_in_row 2

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_student_names) do
    student_names
    |> prepare_students_info
    |> collect_plants_for_students(info_string)
  end

  defp prepare_students_info(student_names) do
    student_names
    |> Enum.sort
    |> Enum.with_index
  end

  defp collect_plants_for_students(students, plants_map) do
    students
    |> Enum.map(fn {student, idx} ->
         {student, plants_for_student(plants_map, idx)}
       end)
    |> Enum.into(%{})
  end

  defp plants_for_student(plants_map, student_idx) do
    plants_map
    |> String.split("\n")
    |> Enum.flat_map(&student_plants_in_row(&1, student_idx))
    |> to_plant_full_names
  end

  defp student_plants_in_row(row, student_idx) do
    row
    |> String.slice(student_idx * @plants_count_in_row, @plants_count_in_row)
    |> String.codepoints
  end

  defp to_plant_full_names([]), do: {}
  defp to_plant_full_names(plants) do
    plants
    |> Enum.map(&(@plants[&1]))
    |> List.to_tuple
  end
end
