require 'test_helper'

class AuctionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Auction.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Auction.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Auction.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to auction_url(assigns(:auction))
  end
  
  def test_edit
    get :edit, :id => Auction.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Auction.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Auction.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Auction.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Auction.first
    assert_redirected_to auction_url(assigns(:auction))
  end
  
  def test_destroy
    auction = Auction.first
    delete :destroy, :id => auction
    assert_redirected_to auctions_url
    assert !Auction.exists?(auction.id)
  end
end
