defmodule Man.Rpc do
  @moduledoc """
  This module contains functions that are called from other pods via RPC.
  """

  alias Man.Templates.API
  alias Man.Templates.Renderer
  alias Man.Templates.Template

  @doc """
  Render template by id

  ## Examples

      iex> Man.Rpc.render_template(1, %{"foo" => "bar"})
      {:ok, "Foo: bar"}
  """
  @spec render_template(id :: binary, params :: map) :: {:ok, binary} | nil | {:error, any}
  def render_template(id, params) do
    render_params =
      Map.merge(
        %{
          "locale" => nil,
          "format" => "text/html"
        },
        params
      )

    with {:ok, %Template{} = template} <- API.get_template(id),
         {:ok, {_format, output}} <- Renderer.render_template(template, render_params) do
      {:ok, output}
    else
      {:error, :not_found} -> nil
      error -> error
    end
  end
end
