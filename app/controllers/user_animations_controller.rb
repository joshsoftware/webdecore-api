# frozen_string_literal: true

class UserAnimationsController < ApplicationController
  def index
    @animations = UserAnimation.all
  end

  def new
  end

  def create
  end


    # def new
    #     @farmer_list = Farmer.all.collect {|u| [u.full_name, u.id]}
    #     @instrument_list = Instrument.all.collect {|u| [u.name, u.id]}
    # end

    # def create
    #     @advertise = FarmerInstrument.create(permit_params)
    #     redirect_to farmer_instruments_path
    end
end
