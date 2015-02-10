# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  buyer_id   :integer
#  driver_id  :integer
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Purchase < ActiveRecord::Base

  belongs_to :buyer, :foreign_key => :buyer_id, class_name: 'User'
  belongs_to :driver, :foreign_key => :driver_id, class_name: 'User'


  # States: instigated, begin_processing, rejected, bought
  # Transitions: attempt_to_buy: instigated -> begin. Success. begin -> bought. Fail begin -> rejected


  # state_machine initial: :pending do
  #   state :pending, value: 0
  #   state :published, value: 1
  # end

  state_machine initial: :instigated do
    event :attempt_to_buy do
      transition :instigated => :begin_processing
      transition :begin_processing => :begin_processing
    end
    
    event :success do
      transition :begin_processing => :bought
    end
    
    event :purchase_has_failed do
      transition :begin_processing => :rejected
    end
  end

end
