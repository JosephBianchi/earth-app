
# Project Title

A brief description of what this project does and who it's for




## Ruby Version
3.0.0


## Run Locally

```bash
  brew install redis

  # ensure redis server has started if it isn't already running
  brew services start redis

  # additional commands

  # stop redis
  brew services stop redis

  # restart redis
  brew services restart redis
```

Clone the project

```bash
  git clone git@github.com:JosephBianchi/earth-app.git
```

Go to the project directory

```bash
  cd earth-app
```

Install dependencies

```bash
  bundle install
```

Start the server

```bash
  rails server
```






## Usage/Examples

```bash
  Incoming requests to system url exp http://localhost:3001/temperatures
  will be saved into a redis list operating as a database

  req format: {
    count: $count, temperatures: [ { temperature: $temperatures, timestamp: $timestamp }, ]
  }

  database format: [
    { temperature: $temperature, temp_change: $temp_change, timestamp: $timestamp},
  ]
```

```bin
  DB example:

    {"temperature"=>10.0, "timestamp"=>"2022-07-11T18:21:28.087-04:00", "temp_change"=>0}
    {"temperature"=>15.555555555555555, "timestamp"=>"2022-07-11T18:21:33.540-04:00", "temp_change"=>5.555555555555555}
    {"temperature"=>21.11111111111111, "timestamp"=>"2022-07-11T18:21:43.124-04:00", "temp_change"=>5.555555555555555}
    {"temperature"=>21.11111111111111, "timestamp"=>"2022-07-11T18:22:29.892-04:00", "temp_change"=>0.0}
    {"temperature"=>21.11111111111111, "timestamp"=>"2022-07-11T18:22:38.308-04:00", "temp_change"=>0.0}
    {"temperature"=>21.11111111111111, "timestamp"=>"2022-07-11T20:04:24.615-04:00", "temp_change"=>0.0}
    {"temperature"=>10.0, "timestamp"=>"2022-07-11T20:04:47.154-04:00", "temp_change"=>-11.11111111111111}
    {"temperature"=>-1.1111111111111112, "timestamp"=>"2022-07-11T20:04:50.646-04:00", "temp_change"=>-11.11111111111111}
    {"temperature"=>18.333333333333332, "timestamp"=>"2022-07-11T20:04:54.099-04:00", "temp_change"=>19.444444444444443}
    {"temperature"=>5.555555555555555, "timestamp"=>"2022-07-11T20:05:03.259-04:00", "temp_change"=>-12.777777777777777}
    {"temperature"=>-5.555555555555555, "timestamp"=>"2022-07-11T20:06:08.788-04:00", "temp_change"=>-11.11111111111111}
    {"temperature"=>-5.555555555555555, "timestamp"=>"2022-07-11T20:06:14.319-04:00", "temp_change"=>0.0}
```


## Authors

- Joseph Bianchi
