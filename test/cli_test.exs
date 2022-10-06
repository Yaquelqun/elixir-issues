defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_descending_order: 1]

  test ":help is returned if we pass -h or --help as an option" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "returns three values if three values are given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "returns three values with default count if two values are given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort descending orders the correct way" do
    result = sort_into_descending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{c b a}
  end

  defp fake_created_at_list(values) do
    for value <- values, do: %{"created_at"=> value, "oter_data" => "xxx"}
  end
end
