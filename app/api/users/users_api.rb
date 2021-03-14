module Api
  module Users   
    class UsersAPI < Grape::API   
     
      format :json   
     
      desc "Get transactions of a user", {   
          :notes => <<-NOTE   
          Get transactions of a user   
           __________________   
          NOTE   
      }   
     
      params do   
        requires :user_id, type: Integer, desc: "User id"   
        optional :account_id, type: Integer, desc: "User id"   
      end

      get ':user_id' do   
        begin   
          if params[:account_id]
            account = Account.find(params[:account_id])
            transactions = account.transaction.all
          else
            transactions = Transaction.all
          end 
        rescue ActiveRecord::RecordNotFound   
          error!({ status: :not_found }, 404)   
        end    
      end     
     
      desc "Create transaction", {   
          :notes => <<-NOTE   
          Create a transaction for a user   
           __________________   
          NOTE   
      }   
     
      params do   
        requires :user_id, type: Integer, desc: "User id"
        requires :account_id, type: Integer, desc: "Account id"
        requires :amount, type: BigDecimal, desc: "Amount"   
        requires :transaction_type, type: String, desc: "Transaction type"   
      end   
     
      post do   
        begin   
          transaction =  Transaction.create({   
                                        amount: params[:amount],   
                                        account_id: params[:account_id],   
                                        transaction_type: params[:transaction_type],                                           
                                    })   
          if transaction.save   
            { status: :success }   
          else   
            error!({ status: :error, message: transaction.errors.full_messages.first }) if transaction.errors.any?   
          end   
     
     
        rescue ActiveRecord::RecordNotFound   
          error!({ status: :error, message: :not_found }, 404)   
        end   
      end   
    end   
  end  
end