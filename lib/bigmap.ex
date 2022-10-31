defmodule BigMap do

    def makeMap(1, map) do
        Map.put(map , "1"  , 1)
    end

    def makeMap(n, map ) do
        Map.put(makeMap(n-1,map), Integer.to_string(n) , n)
    end

end