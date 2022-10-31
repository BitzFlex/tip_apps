defmodule TipApps.FilterOut do
    @moduledoc """
        Header와 Token 사이의 내용을 삭제 한다.
    """

    require Logger


    @doc """
        str 에서 head 앞의 부분을 가져온다.
    """
    def getFront(str,head) do
        case String.split(str, head, parts: 2) do
            [content] -> {content , ""}
            [content, remain] -> {content, remain}
        end
    end

    def getRemain(str,tail) do
        case String.split(str, tail, parts: 2) do
            [_, remain] -> remain
            [_content] -> ""
        end
    end

    def filterOut("",_head,_tail) do
        ""
    end

    def filterOut(str,head,tail) do
        {content, remain} = getFront(str,head)
        remain = getRemain(remain,tail)
        content <> filterOut(remain,head,tail)
    end

    def test do
        IO.puts filterOut("abc()"  , "(" , ")"     )
        IO.puts filterOut("()abc"  , "(" , ")"      )
        IO.puts filterOut("abc()abc()"  , "(" , ")" )
        IO.puts filterOut("abc()abc()abc"  , "(" , ")" )
        IO.puts filterOut("abc(abc)abc()abc"  , "(" , ")" )
        IO.puts filterOut("abc(abc"  , "(" , ")" )
    end

end
