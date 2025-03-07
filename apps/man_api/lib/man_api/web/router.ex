defmodule Man.Web.Router do
  @moduledoc """
  The router provides a set of macros for generating routes
  that dispatch to specific controllers and actions.
  Those macros are named after HTTP verbs.

  More info at: https://hexdocs.pm/phoenix/Phoenix.Router.html
  """

  use Man.Web, :router
  require Logger

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:put_secure_browser_headers)
    plug(EView)
  end

  pipeline :rendering_api do
    plug(:accepts, ["json", "html", "pdf"])
    plug(:put_secure_browser_headers)
  end

  scope "/", Man.Web do
    pipe_through(:api)

    get("/templates", TemplateController, :index)
    post("/templates", TemplateController, :create)

    get("/templates/:id", TemplateController, :show)
    put("/templates/:id", TemplateController, :replace)
    patch("/templates/:id", TemplateController, :update)
    delete("/templates/:id", TemplateController, :delete)

    get("/labels", LabelController, :index)
  end

  scope "/", Man.Web do
    pipe_through(:rendering_api)

    post("/templates/:id/actions/render", TemplateController, :render)
  end
end
