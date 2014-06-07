class Song < ActiveRecord::Base
  state_machine :state, :initial => :queued do
    event :play do
      transition :queued => :played
    end
  end
end
