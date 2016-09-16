class BattlePet < ApplicationRecord
  belongs_to :account

  validates :status, presence: true, length: { maximum: 25 }, inclusion: { in: %w(active locked removed retired resting), message: "Status is not valid" }, allow_nil: false
  validates :strength, presence: true, numericality: { only_decimal: true }
  validates :agility, presence: true, numericality: { only_decimal: true }
  validates :wit, presence: true, numericality: { only_decimal: true }
  validates :speed, presence: true, numericality: { only_decimal: true }
  validates :wisdom, presence: true, numericality: { only_decimal: true }
  validates :intelligence, presence: true, numericality: { only_decimal: true }
  validates :magic, presence: true, numericality: { only_decimal: true }
  validates :chi, presence: true, numericality: { only_decimal: true }
  validates :healing_power, presence: true, numericality: { only_decimal: true }
  validates :experience, presence: true, numericality: { only_integer: true }

  def get_battles
    #TODO update model associations for many to many battles to pets
    battles_started = Battle.where(pet1_id:id)
    challenges = Battle.where(pet2_id:id)
    results = battles_started.present? && challenges.present? ? battles_started+challenges : (battles_started.present? ? battles_started : (challenges.present? ? challenges : Array.new))
  end

  def level_up

  	if experience >= level * BATTLE_PET_LEVEL_UP_EXPERIENCE
  		self.level += 1
  		self.strength += more_strength
      self.agility += more_agility
      self.wit += more_wit
      self.speed += more_speed
      self.wisdom += more_wisdom
      self.intelligence += more_intelligence
      self.magic += more_magic
      self.chi += more_chi
      self.healing_power += more_healing_power
  	end
  end

   def generate_training_battle_pet   
    BattlePet.new({name:"Mr. Battle Pet", status:'active', level:level, experience: ((level-1)*BATTLE_PET_LEVEL_UP_EXPERIENCE)+rand(1..(BATTLE_PET_LEVEL_UP_EXPERIENCE-1)),  strength: more_strength*level, agility: more_agility*level, wit: more_wit*level, speed: more_speed*level, wisdom: more_wisdom*level, intelligence: more_intelligence*level, magic: more_magic*level, chi: more_chi*level, healing_power: more_healing_power*level})    
  end

  def initialize_pet
    self.id=nil
    self.level=1
    self.status='active'
    self.retired=0
    self.experience=0
    self.auto_accept_play_for_points_requests=0
    self.won=0
    self.lost=0
    self.tied=0
    self.strength=more_strength
    self.agility=more_agility
    self.wit=more_wit
    self.speed=more_speed
    self.wisdom=more_wisdom
    self.intelligence=more_intelligence
    self.magic=more_magic
    self.chi=more_chi
    self.healing_power=more_healing_power
  end

  private

  def more_strength
    rand(5..10)
  end

  def more_agility
    rand(5..10)
  end

  def more_wit
    rand(5..10)
  end

  def more_speed
    rand(5..10)
  end

  def more_wisdom
    rand(1..5)
  end

  def more_intelligence
    rand(5..10)
  end

  def more_magic
    rand(1..5)
  end

  def more_chi
    rand(1..5)
  end

  def more_healing_power
    rand(1..5)
  end

end
