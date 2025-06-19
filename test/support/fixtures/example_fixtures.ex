defmodule Capybara.ExampleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Capybara.Example` context.
  """

  @doc """
  Generate a counter.
  """
  def counter_fixture(attrs \\ %{}) do
    {:ok, counter} =
      attrs
      |> Enum.into(%{
        count: 42
      })
      |> Capybara.Example.create_counter()

    counter
  end
end
