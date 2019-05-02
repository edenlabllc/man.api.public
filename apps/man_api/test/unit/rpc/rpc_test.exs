defmodule Man.RpcTest do
  @moduledoc false

  use Man.DataCase, async: true

  alias Man.FixturesFactory
  alias Man.Rpc

  describe "render_template/2" do
    test "success render template" do
      template1 = FixturesFactory.create(:template)
      body = template1.body
      assert {:ok, ^body} = Rpc.render_template(template1.id, %{})
    end

    test "success render template with params" do
      template1 = FixturesFactory.create(:template, body: "Foo: <%= @foo %>", syntax: "iex")
      assert {:ok, "Foo: bar"} = Rpc.render_template(template1.id, %{"foo" => "bar"})
    end

    test "success render template with missed params" do
      template1 = FixturesFactory.create(:template, body: "Foo: <%= @foo %>", syntax: "iex")
      assert {:ok, "Foo: "} = Rpc.render_template(template1.id, %{})
    end

    test "invalid template id" do
      refute Rpc.render_template(DateTime.to_unix(DateTime.utc_now()), %{})
    end
  end
end
