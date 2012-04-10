require 'yaml'

def sha1_digest(str, salt = '')
  Digest::SHA1.hexdigest("#{str}_#{salt}")
end

def load_config(yml_file)
  config_file = File.join Padrino.root, 'config', Padrino.env.to_s, yml_file 
  YAML::load(File.read(config_file))
end

