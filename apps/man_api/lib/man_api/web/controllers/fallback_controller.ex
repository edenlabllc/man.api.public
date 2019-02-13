defmodule Man.Web.FallbackController do
  @moduledoc """
  This controller should be used as `action_fallback` in rest of controllers to remove duplicated error handling.
  """
  use Man.Web, :controller
  alias EView.Views.Error
  alias EView.Views.ValidationError

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(Error)
    |> render(:"404")
  end

  def call(conn, {:error, :locale_not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(Error)
    |> render(:"404", %{type: :locale_not_found})
  end

  def call(conn, {:error, {:unsupported_format, message}}) do
    conn
    |> put_status(415)
    |> put_view(Error)
    |> render(:"415", %{
      message: "Content-Type #{inspect(message)} is not supported"
    })
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ValidationError)
    |> render(:"422", changeset)
  end

  def call(conn, {:error, errors}) when is_list(errors) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ValidationError)
    |> render(:"422", %{schema: errors})
  end
end
