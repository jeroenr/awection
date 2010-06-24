class AuctionsController < ApplicationController
  uses_tiny_mce

  def index
    @auctions = Auction.all
  end

  def show
    @auction = Auction.find(params[:id])
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(params[:auction])
    if @auction.save
      flash[:notice] = "Successfully created auction."
      redirect_to @auction
    else
      render :action => 'new'
    end
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def update
    @auction = Auction.find(params[:id])
    if @auction.update_attributes(params[:auction])
      flash[:notice] = "Successfully updated auction."
      redirect_to @auction
    else
      render :action => 'edit'
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy
    flash[:notice] = "Successfully destroyed auction."
    redirect_to auctions_url
  end
end

