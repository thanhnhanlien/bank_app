class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all   
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(account_params)
    if @transaction.save   
      flash[:notice] = 'Transaction added!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit transaction!'   
      render :new   
    end   
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(account_params)   
      flash[:notice] = 'Transaction updated!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to edit transaction!'   
      render :edit   
    end   
  end

  def destroy
    @transaction = Transaction.find(params[:id])   
    if @transaction.delete   
      flash[:notice] = 'Transaction deleted!'   
      redirect_to root_path   
    else   
      flash[:error] = 'Failed to delete this transaction!'   
      render :destroy   
    end   
  end

  def account_params   
    params.require(:transaction).permit(:amount, :transaction_type, :account_id)   
  end   
end
