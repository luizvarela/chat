defmodule Chat.Topics do
  def add_topic(name) do
    key = name
          |> String.downcase
          |> String.replace(~r/[^a-z0-9+]/, "-")

    Agent.update :topics_agent, fn(topics) -> Map.put(topics, key, name) end
  end

  def list_topics do
    Agent.get :topics_agent, fn(topics) -> topics end
  end

  def start_link do
    Agent.start_link fn -> %{ "lobby" => "Commom Lobby", "html" => "learning HTML" } end, name: :topics_agent
  end
end
