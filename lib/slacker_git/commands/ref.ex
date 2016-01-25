defmodule SlackerGit.Commands.Ref do
  use Slacker.Command

  @usage "ref"
  @short_description "responds with git reference"

  def handle_event({{:command, "ref", _message}, meta}, state) do
    respond("`#{get_reference}`", meta)
    {:ok, state}
  end

  defp get_reference do
    Application.get_env(:slacker, :git_ref) || "<no-ref>"
  end
end
