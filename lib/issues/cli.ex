defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handles the command line parsing to turn inputs into arguments that
  can feed into our app
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.
  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> internal_parse()
  end

  def internal_parse([user, project, count]) do
    { user, project, String.to_integer(count) }
  end

  def internal_parse([user, project]) do
    { user, project, @default_count }
  end

  def internal_parse(_) do
    :help
  end
end
