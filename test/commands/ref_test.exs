defmodule SlackerGit.Commands.RefTest do
  use ExUnit.Case

  test "it returns the reference" do
    {:ok, manager} = GenEvent.start_link
    GenEvent.add_handler(manager, SlackerGit.Commands.Ref, self)

    message = %{ channel: "channel" }
    Application.put_env(:slacker, :git_ref, "#abcdef")
    GenEvent.notify(manager, {{:command, "ref", {}}, %{bot_pid: self, message: message}})
    assert_receive {:reply, "channel", "`#abcdef`"}
  end

  test "it returns <no-ref> when git_ref is not set" do
    {:ok, manager} = GenEvent.start_link
    GenEvent.add_handler(manager, SlackerGit.Commands.Ref, self)


    Application.put_env(:slacker, :git_ref,nil)
    message = %{ channel: "channel" }
    GenEvent.notify(manager, {{:command, "ref", {}}, %{bot_pid: self, message: message}})
    assert_receive {:reply, "channel", "`<no-ref>`"}
  end
end

