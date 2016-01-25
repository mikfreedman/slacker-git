defmodule SlackerGit.Commands.RefTest do
  use ExUnit.Case

  test "it returns the reference" do
    {:ok, manager} = GenEvent.start_link
    GenEvent.add_handler(manager, SlackerGit.Commands.Ref, self)

    message = %{ channel: "channel" }
    System.put_env("GIT_REF", "#abcdef")
    GenEvent.notify(manager, {{:command, "ref"}, %{bot_pid: self, message: message}})
    assert_receive {:reply, "channel", "`#abcdef`"}
  end
end

