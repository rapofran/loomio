class MarketingController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      if third_party_install?
        redirect_to explore_path
      else
        render layout: false
      end
    end
  end
end
