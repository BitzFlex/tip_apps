defmodule PushBullet do


    def push(title, message) do

        # https://www.pushbullet.com/#settings/account 에서 개인 토큰 생성
        token = "o.oIZFWawhMqOUJ0RIZ3zvg0VuvJ3sn8AL"

        headers = ["Access-Token": token]
        {:ok, response} = HTTPoison.get("https://api.pushbullet.com/v2/users/me" , headers)
        %{body: body, status_code: code} = response
        IO.puts "Result = #{code} , Body = #{body}"


        payload = %{body: message, title: title, type: "note"}
        body = Poison.encode!(payload)


        headers = ["Access-Token": token , "Content-Type": "application/json"]
        {:ok, response} = HTTPoison.post("https://api.pushbullet.com/v2/pushes", body , headers)
        %{body: _body, status_code: code} = response
        IO.puts "Result = #{code} , Body = #{body}"
        code
    end

    def push() do
        push("title", "message")
    end
end
