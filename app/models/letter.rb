class Letter < ActiveRecord::Base
  def self.increase_send_count
    self.first.update_columns(send_count: self.first.send_count + 1)
  end

  def self.current_send_count
    self.first.send_count
  end
end
