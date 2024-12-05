defmodule Aoc2024 do
  @moduledoc """
  Documentation for `Aoc2024`.
  """

  @doc """
  day1 puzzle

  ## Examples

      iex> Aoc2024.total_distance()
      123

  """
  @spec total_distance() :: non_neg_integer()
  def total_distance() do
    {:ok, contents} = File.read("lib/aoc/input.csv.csv")

    rows = String.split(contents, "\n")

    [_header | data_rows] = rows

    left_right =
      Enum.map(data_rows, fn row ->
        case String.split(row, ",") do
          [left, right] ->
            {String.to_integer(String.trim(left)), String.to_integer(String.trim(right))}

          _ ->
            nil
        end
      end)

    left_right = Enum.filter(left_right, fn x -> x != nil end)

    left = Enum.map(left_right, fn {l, _r} -> l end)
    right = Enum.map(left_right, fn {_l, r} -> r end)
    calculate_differences(left, right)
  end

  defp calculate_differences(left, right) do
    sorted_left = Enum.sort(left)
    sorted_right = Enum.sort(right)

    differences =
      Enum.zip(sorted_left, sorted_right)
      |> Enum.map(fn {l, r} -> abs(l - r) end)

    Enum.sum(differences)
  end
end
