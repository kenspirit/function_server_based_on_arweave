defmodule FunctionServerBasedOnArweaveWeb.BuidlerController do
  use FunctionServerBasedOnArweaveWeb, :controller

  def sign_in_from_live_view(conn, %{"lid" => lid, "returns_to" => returns_to}) do
    addr =
      case :ets.lookup(:buidler_login, lid) do
        [{_, addr}] ->
          :ets.delete(:buidler_login, lid)
          addr
        _ ->
          -1
      end

    FunctionServerBasedOnArweaveWeb.AuthHelpers.login_as_buidler(conn, addr)
    |> redirect(to: returns_to)
  end
end
