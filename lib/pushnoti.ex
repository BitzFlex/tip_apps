defmodule PushNoti do

    def gcm(_message) do
        id = "APA91bHA8gX0IXDr-N0gWMA4414X8-XIB8zUS_1dYVGOOxySj2lwp32atknAvrqa2g4MvDgHn6g8T32EYe0cKtgqUEeHDAlnNCFP3UZbz_xbe_P8wuFWTk_jQHg62zpYwbBkj6Lr6_kJ"

        GCM.push("AIzaSyBgTZfcD_w0r80zlHLhxw19maiOomCGadY", [id], %{notification: %{ title: "Hello!"} })
    end


    def fcm(message) do
        config = %Pigeon.FCM.Config{
            key: "AAAAey1bWuo:APA91bHvL5b4igzNxLi_9Y9o_DlVMEu_mqTJYbAONFShshWYttSZ1X-odH11VY9L-U5fdMNqBYvu0OJnalx1dJQ7uq7i8tIIjouYeAfPZxDg-0Eh5zz9_KRabNwTCHdKki8HUhcFt8Km",
            name: :fcm_default,
            port: 443,
            uri: 'fcm.googleapis.com'
          }

          {:ok, pid} = Pigeon.FCM.start_connection(%{config | name: nil})
          n = Pigeon.FCM.Notification.new("fehd6Bwxgaw:APA91bGjaMHUCwz1ZlwelDRcxh-3CvaKkABluebWKXdVckCSnlppuf7005gxY84SWgoKknjyVK8VZrCqpR53QbkF6ixZO2wfkYeByhANXejnx8krNDpdJAjM1AzD3EYXYdpFWqPKghTh",
                                        %{},
                                        %{"message" => message})
          result = Pigeon.FCM.push(n)
          IO.puts "Result : #{inspect result}"

          Pigeon.FCM.stop_connection(pid)
    end
end
