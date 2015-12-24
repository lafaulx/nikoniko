defmodule Nikoniko.Router do
  use Nikoniko.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Nikoniko do
    pipe_through :browser # Use the default browser stack

    get "/", ClientController, :index
    get "/stats", StatsController, :index
  end

  scope "/api", Nikoniko do
    pipe_through :api

    resources "/moods", MoodController, only: [:index, :create, :show]
  end
end
