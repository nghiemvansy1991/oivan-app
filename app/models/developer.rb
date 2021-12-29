class Developer < ApplicationRecord
  belongs_to :project

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :kept, -> { undiscarded.joins(:project).merge(Project.kept) }

  def kept?
    undiscarded? && project.kept?
  end
end
