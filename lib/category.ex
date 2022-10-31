defmodule Category do
   
    


    def mapOfKey(list, key) do
        
    end


    def cat do
       data = [
                %{"a"=>1} , %{"a"=>2} , %{"a"=>3}, 
                %{"b"=>4} , %{"b"=>5} , %{"b"=>6}
              ]

        data 
            |> Enum.reduce(%{} , 
                           fn m , acc ->
                                key = Map.keys(m) |> List.first
                                value = Map.fetch!(m,key)
                                Map.merge(acc,%{key => [value]} )
                            end )


    end

end