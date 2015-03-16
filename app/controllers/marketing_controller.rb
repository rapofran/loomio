class MarketingController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      if show_loomio_org_marketing
        render layout: false
      else
        redirect_to explore_path
      end
    end
  end
end
