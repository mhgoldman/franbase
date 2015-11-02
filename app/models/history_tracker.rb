class HistoryTracker
  include Mongoid::History::Tracker
  before_create :set_creator

  def set_creator
    self.modifier = User.last
  end
end