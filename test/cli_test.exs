defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1] # we need to inport the things that we want to test

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
end
