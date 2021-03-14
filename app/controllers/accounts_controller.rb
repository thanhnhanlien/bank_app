class AccountsController < ApplicationController
  def index
    @accounts = Account.all   
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)   
    @account.user_id = current_user.id
    if @account.save   
      flash[:notice] = 'Account added!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit account!'   
      render :new   
    end   
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])  
    @account.user_id = current_user.id 
    if @account.update_attributes(account_params)   
      flash[:notice] = 'Account updated!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit account!'   
      render :edit   
    end   
  end

  def destroy
    @account = Account.find(params[:id])   
    if @account.delete   
      flash[:notice] = 'Account deleted!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to delete this account!'   
      render :destroy   
    end   
  end

  def account_params   
    params.require(:account).permit(:name, :bank, :user_id)   
  end   
end
