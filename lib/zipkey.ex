defmodule ZipKey do
    
    def zipkey(tuplelist) do
        #tuplelist = [{"GW1", Node1}, {"GW2", "node1"}, {"GW1", "Node2"}, {"GW1", "Node3"}, {"GW2", "node2"}]
    
        List.foldr(tuplelist, %{}, fn {key, value}, accmap ->
          Map.put(accmap, key, List.insert_at( Map.get(accmap, key) || [], 0, value))
        end)
      end
   

end