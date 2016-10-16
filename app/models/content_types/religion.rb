class Religion < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  validates :user_id, presence: true

  belongs_to :universe

  include HasPrivacy
  include HasContentGroupers
  include Serendipitous::Concern

  # Characters
  # relates :notable_figures, with: :something
  # relates :dieties, with: :something

  # Locations
  # relates :practicing_locations, with: :something

  # Items
  # relates :artifacts, with: :something

  scope :is_public, -> { eager_load(:universe).where('creatures.privacy = ? OR universes.privacy = ?', 'public', 'public') }

  def self.color
    'yellow'
  end

  def self.icon
    'brightness_7'
  end

  def self.attribute_categories
    {
      overview: {
        icon: 'info',
        attributes: %w(name other_names universe_id)
      },
      info: {
        icon: 'face',
        attributes: %w(history typology dialectical_information register)
      },
      phonology: {
        icon: 'fingerprint',
        attributes: %w(phonology)
      },
      grammar: {
        icon: 'groups',
        attributes: %w(grammar)
      },
      entities: {
        icon: 'groups',
        attributes: %w(numbers quantifiers)
      },
      # lexicon: {
      #   icon: 'info',
      #   attributes: %w()
      # },
      # spoken_by: {
      #   icon: 'info',
      #   attributes: %w()
      # },
      notes: {
        icon: 'edit',
        attributes: %w(notes private_notes)
      }
    }
  end
end
