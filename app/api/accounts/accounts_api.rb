module Api
  module Accounts   
    class AccountsAPI < Grape::API   
     
      format :json   
     
      desc "Account List", {   
          :notes => <<-NOTE   
          Get All Account   
           __________________   
          NOTE   
      }   
     
      get do   
        Account.all   
      end   
     
     
      desc "Account By Id", {   
          :notes => <<-NOTE   
          Get Account By Id   
           __________________   
          NOTE   
      }   
     
      params do   
        requires :id, type: Integer, desc: "Account id"   
      end   
     
      get ':id' do   
        begin   
          account = Account.find(params[:id])   
        rescue ActiveRecord::RecordNotFound   
          error!({ status: :not_found }, 404)   
        end   
      end   
     
      desc "Delete Account By Id", {   
          :notes => <<-NOTE   
          Delete Account By Id   
           __________________   
          NOTE   
      }   
     
      params do   
        requires :id, type: Integer, desc: "Account id"   
      end   
     
      delete ':id' do   
        begin   
          account = Account.find(params[:id])   
          { status: :success } if account.delete   
        rescue ActiveRecord::RecordNotFound   
          error!({ status: :error, message: :not_found }, 404)   
        end   
      end   
     
      desc "Update Account By Id", {   
          :notes => <<-NOTE   
          Update Account By Id   
                          __________________   
          NOTE   
      }   
     
      params do   
        requires :id, type: Integer, desc: "Account id"   
        requires :name, type: String, desc: "Account name"   
        requires :bank, type: BigDecimal, desc: "Account bank"   
        optional :user_id, type: BigDecimal, desc: "User_id"   
      end   
     
      put ':id' do   
        begin   
          account = Account.find(params[:id])   
          if account.update({   
                                name: params[:name],   
                                bank: params[:bank],   
                                user_id: params[:user_id],                                
                            })   
            { status: :success }   
          else   
            error!({ status: :error, message: account.errors.full_messages.first }) if account.errors.any?   
          end   
     
     
        rescue ActiveRecord::RecordNotFound   
          error!({ status: :error, message: :not_found }, 404)   
        end   
      end   
     
     
      desc "Create Account", {   
          :notes => <<-NOTE   
          Create Account   
           __________________   
          NOTE   
      }   
     
      params do   
        requires :name, type: String, desc: "Account name"   
        requires :bank, type: BigDecimal, desc: "Account bank"   
        optional :user_id, type: BigDecimal, desc: "User id"
        
      end   
     
      post do   
        begin   
          account =  Account.create({   
                                        name: params[:name],   
                                        bank: params[:bank],   
                                        user_id: params[:user_id],                                           
                                    })   
          if account.save   
            { status: :success }   
          else   
            error!({ status: :error, message: account.errors.full_messages.first }) if account.errors.any?   
          end   
     
     
        rescue ActiveRecord::RecordNotFound   
          error!({ status: :error, message: :not_found }, 404)   
        end   
      end   
    end   
  end  
end