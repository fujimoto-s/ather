defmodule Util do
  def bin_to_str_rep(bin) do
    str = bin_to_intlist(bin) |> Enum.join(", ")
    "<< " <> str <> " >>"
  end

  def bin_to_intlist(<<c, bin::bitstring>>) do
     case byte_size(bin) do
       0 -> [c]
       _ -> [c] ++ bin_to_intlist(bin)
     end
  end
end
