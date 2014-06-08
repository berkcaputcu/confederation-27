class Song < ActiveRecord::Base
  state_machine :state, :initial => :queued do
    after_transition :on => :play, :do => [ :increment_times_played, :touch_played_at]

    event :play do
      transition :queued => :played
    end

    event :reset do
      transition :played => :queued
    end
  end

  def increment_times_played
    self.times_played += 1
    save
  end

  def touch_played_at
    touch(:played_at)
  end
end
