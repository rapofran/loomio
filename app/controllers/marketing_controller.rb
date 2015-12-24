class MarketingController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      @stories = BlogStory.order('published_at DESC').limit(4)
      render layout: false
    end
  end
end
