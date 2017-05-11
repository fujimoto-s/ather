defmodule Packet do
  require Logger
  alias Util

  def msg_map do
    %{
      :hello => 0,
      :features_req => 5
    }
  end

  def parse(bin) do
    Logger.debug "Parsing: #{Util.bin_to_str_rep(bin)}"
    << version::size(8), typenum::size(8), length::size(16), xid::size(32), data::bitstring >> = bin

    type = get_type(typenum)
    Logger.debug "Msg Type: #{type}"
    case type do
      :hello -> Packet.Hello.decode(bin)
      :features_req -> Packet.FeatureReq.decode(bin)
    end
  end

  def get_type(num) do
    Enum.find(msg_map(), fn {_, val} -> val == num end)
    |> elem(0)
  end
end
