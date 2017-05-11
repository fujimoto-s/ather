defmodule PacketTest.Hello do
  use ExUnit.Case
  doctest Ather

  test "hello_BinaryaAnalyze" do
    bin = << 0x04, # version(4)
             0x00, # type(0)
             0x00, 0x08, # length(0)
             0x12, 0x34, 0x56, 0x78, # xid
             >>
    hello = Packet.Hello.decode(bin)
    assert hello.version == 4
    assert hello.type == :hello
    assert hello.length == 8
    assert hello.xid == 0x12345678

    bin2 = Packet.Hello.encode(hello)
    assert bin == bin2
  end
end
