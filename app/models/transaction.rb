class Transaction < ApplicationRecord
	belongs_to :account

	validates :amount, presence: true   
	validates :transaction_type, presence: true
	validates :account_id, presence: true
end
