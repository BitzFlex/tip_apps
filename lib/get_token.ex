defmodule GetToken do
    def get("",_,_,acc) do
        Enum.reverse  acc
    end

    def get(nil,_,_,acc) do
        Enum.reverse  acc
    end

    def get(str,head,tail,acc) do
        with [_, text] <- String.split(str,head, parts: 2),
             [token, remain] <- String.split(text, tail, parts: 2)
        do
            get(remain, head, tail, [token | acc])
        else
            _ -> Enum.reverse acc
        end
    end


    def get(str,head,tail) do
        require IEx; IEx.pry
        get(str,head,tail,[])
    end

    def test do
        data = """
        <tr>
          <th><input name='allcheck' onclick="javascript:ck_all();"  type="checkbox"/></th>
          <th>순번</th>
          <th>이름</th>
          <th>나이</th>
          <th>핸드폰</th>
          <th>정보</th>
          <th>등록일</th>
          <th>IP</th>
          <th>삭제</th>
          <th>페이지</th>
          <th width="30%">문의내용</th>
          <th>상담일시</th>
        </tr>
        """

        # get("<tr> abc </tr>  <tr> 123 </tr>\n\n<tr>가나다 </tr>","<tr>","</tr>",[])
        get(data,"<tr>","</tr>",[]) |> Enum.at(0) |> get("<th","</th>",[])
        # get("",",", "]", [])
    end

end
