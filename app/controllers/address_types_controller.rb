class AddressTypesController < ApplicationController
  # GET /address_types
  # GET /address_types.xml
  def index
    @address_types = AddressType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @address_types }
    end
  end

  # GET /address_types/1
  # GET /address_types/1.xml
  def show
    @address_type = AddressType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address_type }
    end
  end

  # GET /address_types/new
  # GET /address_types/new.xml
  def new
    @address_type = AddressType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address_type }
    end
  end

  # GET /address_types/1/edit
  def edit
    @address_type = AddressType.find(params[:id])
  end

  # POST /address_types
  # POST /address_types.xml
  def create
    @address_type = AddressType.new(params[:address_type])

    respond_to do |format|
      if @address_type.save
        format.html { redirect_to(@address_type, :notice => 'AddressType was successfully created.') }
        format.xml  { render :xml => @address_type, :status => :created, :location => @address_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @address_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /address_types/1
  # PUT /address_types/1.xml
  def update
    @address_type = AddressType.find(params[:id])

    respond_to do |format|
      if @address_type.update_attributes(params[:address_type])
        format.html { redirect_to(@address_type, :notice => 'AddressType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /address_types/1
  # DELETE /address_types/1.xml
  def destroy
    @address_type = AddressType.find(params[:id])
    @address_type.destroy

    respond_to do |format|
      format.html { redirect_to(address_types_url) }
      format.xml  { head :ok }
    end
  end
end
