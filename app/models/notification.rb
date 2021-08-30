class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true
  belongs_to :incident, optional: true
  before_save :attach_incident

  def attach_incident
    self.incident = params[:incident]

  end

  # def message
  #   "message"
  # end
  # #
  # def url
  #   incident_path(incident)
  # end
end
