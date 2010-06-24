require 'test_helper'

class AddressTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => AddressType.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    AddressType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    AddressType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to address_type_url(assigns(:address_type))
  end
  
  def test_edit
    get :edit, :id => AddressType.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    AddressType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AddressType.first
    assert_template 'edit'
  end
  
  def test_update_valid
    AddressType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AddressType.first
    assert_redirected_to address_type_url(assigns(:address_type))
  end
  
  def test_destroy
    address_type = AddressType.first
    delete :destroy, :id => address_type
    assert_redirected_to address_types_url
    assert !AddressType.exists?(address_type.id)
  end
end
