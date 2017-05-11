defmodule Packet.Hello do
  alias Packet
  defstruct version: 4,
            type: :hello,
            length: 8,
            xid: 0

  def decode(<<version::size(8), type::size(8), length::size(16), xid::size(32)>>) do
    %Packet.Hello{version: version, type: Packet.get_type(type), length: length, xid: xid}
  end

  def encode(%Packet.Hello{version: version, type: type, length: length, xid: xid}) do
    <<version::size(8), Packet.msg_map[type]::size(8), length::size(16), xid::size(32)>>
  end
end
