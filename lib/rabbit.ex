defmodule RabbitMQExam do

  def config do
    Application.fetch_env!(:tip_apps, RabbitConfig)

  end

  def open do
    {:ok, connection} = config() |>  AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)

    {connection,channel}
  end

  #-------------------------------   Simple Direct -----------
  def directSend(msg \\ "Hello World!") do
    {connection,channel} = open()
    AMQP.Queue.declare(channel, "hello")
    AMQP.Basic.publish(channel, "", "hello", msg)
    AMQP.Connection.close(connection)
  end

  def directReceiveHandler do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts " [#{inspect self()}] Received #{payload}\n meta : #{inspect meta}"
        directReceiveHandler()
    end
  end

  def directReceiveProcess do
    {_connection,channel} = open()
    AMQP.Queue.declare(channel, "hello")
    AMQP.Basic.consume(channel, "hello", nil, no_ack: true)

    directReceiveHandler()
  end


  def directReceive do
    spawn(&directReceiveProcess/0)
  end

  #-------------------------------   Fan out -----------
  def fanoutSend(msg \\ "Fanout Message") do
    {connection,channel} = open()
    AMQP.Exchange.declare(channel, "logs" , :fanout)
    AMQP.Basic.publish(channel, "logs", "" , msg)
    AMQP.Connection.close(connection)
  end


  def fanoutReceiveHandler do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts " [#{inspect self()}] Received #{payload}\n meta : #{inspect meta}"
        fanoutReceiveHandler()
    end
  end

  def fanoutReceiveProcess() do
    {_connection,channel} = open()

    AMQP.Exchange.declare(channel, "logs" , :fanout)
    {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel, "", exclusive: true)
    AMQP.Queue.bind(channel, queue_name, "logs"  )
    AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)

    fanoutReceiveHandler()
  end


  def fanoutReceive() do
    spawn(&fanoutReceiveProcess/0)
  end



  #-------------------------------   Routing -----------
  def routingSend(msg \\ "Routing Message" , routing_key \\ "") do
    {connection,channel} = open()
    AMQP.Exchange.declare(channel, "routing_exchange" , :direct)
    AMQP.Basic.publish(channel, "routing_exchange", routing_key , msg)
    AMQP.Connection.close(connection)
  end


  def routingReceiveHandler do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts " [#{inspect self()}] Received #{payload}\n meta : #{inspect meta}"
        routingReceiveHandler()
    end
  end

  def routingReceiveProcess(routing_key) do
    {_connection,channel} = open()

    AMQP.Exchange.declare(channel, "routing_exchange" , :direct)
    {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel, "", exclusive: true)
    AMQP.Queue.bind(channel, queue_name, "routing_exchange" , routing_key: routing_key )
    AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)

    routingReceiveHandler()
  end


  def routingReceive(routing_key \\ "") do
    spawn(fn -> routingReceiveProcess(routing_key)  end)
  end




end
