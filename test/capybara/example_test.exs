defmodule Capybara.ExampleTest do
  use Capybara.DataCase

  alias Capybara.Example

  describe "examples" do
    alias Capybara.Example.Counter

    import Capybara.ExampleFixtures

    @invalid_attrs %{count: nil}

    test "list_examples/0 returns all examples" do
      counter = counter_fixture()
      assert Example.list_examples() == [counter]
    end

    test "get_counter!/1 returns the counter with given id" do
      counter = counter_fixture()
      assert Example.get_counter!(counter.id) == counter
    end

    test "create_counter/1 with valid data creates a counter" do
      valid_attrs = %{count: 42}

      assert {:ok, %Counter{} = counter} = Example.create_counter(valid_attrs)
      assert counter.count == 42
    end

    test "create_counter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Example.create_counter(@invalid_attrs)
    end

    test "update_counter/2 with valid data updates the counter" do
      counter = counter_fixture()
      update_attrs = %{count: 43}

      assert {:ok, %Counter{} = counter} = Example.update_counter(counter, update_attrs)
      assert counter.count == 43
    end

    test "update_counter/2 with invalid data returns error changeset" do
      counter = counter_fixture()
      assert {:error, %Ecto.Changeset{}} = Example.update_counter(counter, @invalid_attrs)
      assert counter == Example.get_counter!(counter.id)
    end

    test "delete_counter/1 deletes the counter" do
      counter = counter_fixture()
      assert {:ok, %Counter{}} = Example.delete_counter(counter)
      assert_raise Ecto.NoResultsError, fn -> Example.get_counter!(counter.id) end
    end

    test "change_counter/1 returns a counter changeset" do
      counter = counter_fixture()
      assert %Ecto.Changeset{} = Example.change_counter(counter)
    end
  end
end
