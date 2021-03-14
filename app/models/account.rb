class Account < ApplicationRecord
	belongs_to :user
	has_many :transactions

	validates :name, presence: true   
	validates :bank, presence: true
	validates :user_id, presence: true
end
