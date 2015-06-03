require 'active_model'

class Skill

  YAML_FILE_PATH = Bundler.root + 'skills.yaml'

  def self.read
    YAML.load_file(YAML_FILE_PATH)
  end

  def self.write(skills)
    YAML_FILE_PATH.open('w'){|f| f.puts(skills.to_yaml) }
  end

  def self.all
    @all ||= read.map(&method(:new))
  end

  def self.save
    # add some collection validations
    write all.map(&:to_hash)
  end

  def self.find(id)
    self.all.find do |skill|
      skill.id == id
    end
  end

  include ActiveModel::Model

  attr_accessor \
    :id, 
    :name, 
    :prerequisite_skill_ids,
    :day_introduced

  validates_presence_of :id
  validates_presence_of :name

  def initialize(attributes={})
    @id = attributes[:id]
    @name = attributes[:name]
    @prerequisite_skill_ids = attributes[:prerequisite_skill_ids] || []
    @day_introduced = attributes[:day_introduced]
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

  def prerequisites
    prerequisite_skill_ids.map do |prerequisite_skill_id|
      self.class.find(prerequisite_skill_id)
    end
  end

  def prerequisite_skill?(skill)
    prerequisite_skill_ids.include?(skill.id)
  end

  def deep_prerequisites
    prerequisites = self.prerequisites
    prerequisites.each do |skill|
      prerequisites += skill.deep_prerequisites
    end
    prerequisites.uniq
  end

  def to_hash
    {
      id: @id,
      name: @name,
      prerequisite_skill_ids: @prerequisite_skill_ids,
      day_introduced: @day_introduced,
    }
  end

  def as_json(options={})
    to_hash
  end


end
