defmodule AdGet.Functions.FilterIn do
    @moduledoc """
        Header와 Token 사이의 내용만 남긴다.
    """

    require Logger


    @doc """
        str 에서 head 앞의 부분을 가져온다.
    """
    def getFront(str,head) do
        case String.split(str, head, parts: 2) do
            [_notfound] -> ""    #head로 시작하는 것이 없으므로 다 버린다. 
            [_prev, next] -> next  # head 이전의 것과 head를 버리고, head 이후의 값을 반환 
        end
    end

    def getRemain(str,tail) do
        case String.split(str, tail, parts: 2) do
            [_notfount] -> {"", ""}  # tail로 끝나지 않았으므로 버린다. 
            [content, remain] -> {content , remain}
        end
    end

    def filterIn("",_head,_tail) do
        ""
    end

    def filterIn(str,{head_start,head_end},{tail_start,tail_end}) do
        content = getFront(str,head_start)
        content = getFront(content,head_end)
        {content, remain} = getRemain(content,tail_start)
        remain = getFront(remain,tail_end)

        content <> filterIn(remain,{head_start,head_end},{tail_start,tail_end})
    end

    def filterIn(str,{head_start,head_end},tail) do
        content = getFront(str,head_start)
        content = getFront(content,head_end)
        {content, remain} = getRemain(content,tail)

        content <> filterIn(remain,{head_start,head_end},tail)
    end


    def filterIn(str,head,tail) do
        content = getFront(str,head)
        {content, remain} = getRemain(content,tail)

        content <> filterIn(remain,head,tail)
    end

    def test do
        IO.puts filterIn("abc()"  , "(" , ")"     )
        IO.puts filterIn("()abc"  , "(" , ")"      )
        IO.puts filterIn("abc()abc()"  , "(" , ")" )
        IO.puts filterIn("abc()abc()abc"  , "(" , ")" )
        IO.puts filterIn("abc(abc)abc()abc"  , "(" , ")" )
        IO.puts filterIn("abc(abc"  , "(" , ")" )
        IO.puts filterIn("abcabc)"  , "(" , ")" )
        IO.puts filterIn("abcabc)"  , "a" , "c" )
        IO.puts filterIn("abc(abc)abc(123)abc"  , "(" , ")" )
        IO.puts filterIn("content <start decoration>body<end>tail content <start decoration>body<end>tail content <start decoration>body<end>tail", {"<start",">"} , "<end>" )
        IO.puts filterIn("content <start decoration>body<end >tail content <start decoration>body< end>tail content <start decoration>body<en d>tail", {"<start",">"} ,{"<",">"} )

    end

end
