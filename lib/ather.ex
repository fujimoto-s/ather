defmodule Ather do
  import Packet
  import Reactor

  def main([]) do
    socket = connect('localhost', 6653)
    pid = spawn(Ather, :send_msg, [socket])
    recv_loop(socket, pid)
  end

  def connect(addr, port) do
    socket = case :gen_tcp.connect(addr, port, [:binary, active: false, packet: 0]) do
      {:ok, socket} -> socket
      {:error, reason} -> exit(reason)
    end
    socket
  end

  def recv_loop(socket, pid) do
    send? = case :gen_tcp.recv(socket, 0) do
      {:ok, packet} -> packet
      {:error, reason} -> reason
    end
    |> parse
    |> reactor

    case send? do
       {:send, msg} -> send(pid, {:send, msg})
       _ -> recv_loop(socket,pid)
    end
    recv_loop(socket, pid)
  end

  def send_msg(socket) do
    receive do
      {:send, msg} ->
        :gen_tcp.send(socket, msg)
        send_msg(socket)
    end
  end
end
