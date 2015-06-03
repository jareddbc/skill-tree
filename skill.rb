require 'yaml'
require 'active_model'

class Skill

  YAML_FILE_PATH = Bundler.root + 'skills.yaml'

  def self.all
    @all ||= YAML.load_file(YAML_FILE_PATH).map(&method(:new))
  end

  def self.save
    # add some collection validations
    yaml = all.map(&:to_hash).to_yaml
    YAML_FILE_PATH.open('w'){|f| f.puts(yaml) }
  end

  def self.find(id)
    self.all.find do |skill|
      skill.id == id
    end
  end

  include ActiveModel::Model

  attr_accessor :id, :name, :dependency_skill_ids

  validates_presence_of :id
  validates_presence_of :name

  def initialize(attributes={})
    @id = attributes[:id]
    @name = attributes[:name]
    @dependency_skill_ids = attributes[:dependency_skill_ids] || []
  end

  def save
    return false unless valid?
    self.class.all.push(self) unless self.class.all.include?(self)
    self.class.save
  end

  def delete
    self.class.all.delete(self)
    self.class.save
  end

  def dependencies
    dependency_skill_ids.map do |dependency_skill_id|
      self.class.find(dependency_skill_id)
    end
  end

  def dependent_on?(skill)
    dependency_skill_ids.include?(skill.id)
  end

  def deep_dependencies
    dependencies = self.dependencies
    dependencies.each do |dependency|
      dependencies += dependency.deep_dependencies
    end
    dependencies.uniq
  end

  def to_hash
    {
      id: @id,
      name: @name,
      dependency_skill_ids: @dependency_skill_ids,
    }
  end


end
