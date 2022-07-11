class TemperaturesController < ApplicationController
  REDIS_LIST_KEY = 'synced_space_temperatures' # fake DB

  def create
    # - would probably rename this route - as it creates more than 1 record;
    # and it could be a bit mis-leading

    # - fake validating record(s) are created
    # - also, this logic would be moved into a model
    puts 'earth db'
    puts redis.lrange(REDIS_LIST_KEY, 0, -1)
    puts '--'
    prev_db_count = redis.lrange(REDIS_LIST_KEY, 0, -1).count
    temperatures_param.each do |temperature_obj|
      temperature_obj['temp_change'] =
        parsed_temp(last_sync_temperature) ?
          temperature_obj['temperature'] - parsed_temp(last_sync_temperature) :
          0
      redis.rpush(REDIS_LIST_KEY, temperature_obj)
    end

    if sync_success?(prev_db_count, temperatures_param.count)
      render json: { message: 'temperature_received' }, status: 201
      # could add logic here to deal with bad data - or data that was unable to be inserted
      # pretending all data valid
    end
  end

  private
  def redis
    @redis ||= $redis
  end

  def db_array
    @db_array = redis.lrange(REDIS_LIST_KEY, 0, -1)
  end

  def temperature_data_param
    @temperature_data_param ||= JSON.parse(params['temperature_data'])
  end

  def temperatures_param
    @temperatures_param ||= temperature_data_param['temperatures']
  end

  def temperature_count_param
    temperature_data_param['count']
  end

  def sync_success?(prev_db_count, new_records)
    prev_db_count + new_records == redis.lrange(REDIS_LIST_KEY, 0, -1).count
  end

  def last_sync_temperature
    # if used different db would just use active-record query
    db_array.sort_by { |temp_obj| parsed_time(temp_obj) }.last
  end

  # hack get timestamp - since using string values from redis and not standard DB
  def parsed_time(str)
    string_begin = "\"timestamp\"=>\""
    string_end = "\""
    str[/#{string_begin}(.*?)#{string_end}/m, 1].to_datetime
  end

  # hack get temperature - since using string values from redis and not standard DB
  def parsed_temp(str)
    return nil if str.blank?
    string_begin = "\"temperature\"=>"
    string_end = ","
    str[/#{string_begin}(.*?)#{string_end}/m, 1].to_f
  end
end
