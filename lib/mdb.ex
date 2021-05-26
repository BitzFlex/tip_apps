defmodule MDB do

  require Logger

  def connect do

    mongoConfig = Application.fetch_env!(:tip_apps, MongoConfig)
                    |> Keyword.put(:name, :mongo)
    Logger.info("MongoDB Config : #{inspect(mongoConfig , pretty: true)}")

    Mongo.start_link(mongoConfig)
  end

  def insertSample do
    1..1_000
      |> Enum.each(fn i ->
                      name = "hippo#{rem(i,10)}"
                      doc_map = %{"name" => name, "no" => i , "ts" =>  System.os_time(:second), "no2" => i * 10 }
                      Mongo.insert_one(:mongo,"sample",doc_map)
                   end)
  end

  def findall(name) do
    filter = %{"name" => name}

    option = [
      projection: [_id: 0 , name: 1, no: 1],
      sort: %{"no" => -1},
    ]
    Mongo.find(:mongo, "sample" , filter , option)
  end

  def findByFilter(filter) do
    option = [
      projection: [_id: 0 , name: 1, no: 1],
      sort: %{"no" => -1},
    ]
    Mongo.find(:mongo, "sample" , filter , option)
  end

  def lastOne(name) do
    filter = %{"name" => name}

    option = [
      sort: %{"ts" => -1},
      projection: [_id: 0 , body: 1, no: 1],
      limit: 1
    ]

    Mongo.find(:mongo, "sample" , filter , option)
      |> Enum.to_list()
      |> Enum.at(0)
  end

  def mostOne(name, desc \\ true) do

    filter = %{"name" => name}
    sort = %{"no" => (if desc, do: -1, else: 1) }

    option = [
      sort: sort,
      limit: 1
    ]

    Mongo.find(:mongo, "sample" , filter , option)
      |> Enum.to_list()
      |> Enum.at(0)
  end


  def sumOf(name) do
    agg = [
      [ "$match":   [name: name]],
      [ "$group":  [ _id: [ name: "$name"],
                     sum: ["$sum": "$no" ],
                     avg: ["$avg": "$no"]
                    ]
      ]
    ]

    Mongo.aggregate(:mongo, "sample", agg, [allow_disk_use: true])
      |> Enum.to_list()
      |> List.first()
  end






end
