class Resource < ApplicationRecord
  belongs_to :user
  scope :by_name, -> (name) { where(name: name) }

  # Handle merging rather than replacing entire data
  # structure to allow partial updates
  def data=(new_data = {})
    super(self.data.deep_merge(new_data))
  end

  def as_json(options = nil)
    super({ only: [:id, :created_at, :updated_at] }.merge(options || {}))
      .merge(data)
  end
end
