defmodule Reactor do

  def reactor(packet) do
    case packet.type do
      :hello -> {:send, Packet.Hello.encode(%Packet.Hello{})}
      :features_req
    end
  end
end
