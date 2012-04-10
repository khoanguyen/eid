load_config('memcached.yml').tap do |config|
  servers = config.map do |k,v|
    "#{v['host']}:#{v['port']}"
  end
  MEMCACHE = MemCache.new servers
end