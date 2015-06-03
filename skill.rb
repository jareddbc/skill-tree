require 'yaml'
require 'active_model'

class Skill

  YAML_FILE_PATH = Bundler.root + 'skills.yaml'

  def self.all
    @all ||= YAML.load_file(YAML_FILE_PATH).map(&method(:new))
  end

  def self.save
    yaml = all.map(&:to_hash).to_yaml
    YAML_FILE_PATH.open('w'){|f| f.puts(yaml) }
  end

  include ActiveModel::Model

  attr_accessor :id, :name, :dependencies

  validates_presence_of :id
  validates_presence_of :name

  def initialize(attributes={})
    @id = attributes[:id]
    @name = attributes[:name]
    @dependencies = attributes[:dependencies] || []
  end

  def save
    @all.push(self) unless @all.include?(self)
    self.class.save
  end

  def delete
    @all.delete(self)
    self.class.save
  end

  def to_hash
    {
      id: @id,
      name: @name,
      dependencies: @dependencies,
    }
  end


end
