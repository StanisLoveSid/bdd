class UsersController < ApplicationController

  def update
    @user = current_user
    @user.build_user_billing(user_billing_params)
    respond_to do |format|
      if @user.save
        format.html  { redirect_to edit_user_registration_path, notice: 'Your information was successfuly updated' }
      else
      	format.html  { redirect_to edit_user_registration_path, alert: 'Something went wrong' }
      end
    end
  end

  private

  def user_billing_params
    params[:user_billing][:address].permit(:zipcode, :country, :city, :phone, :address, :addressable_type, :addressable_id)
  end
end
