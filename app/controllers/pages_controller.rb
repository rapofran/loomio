class PagesController < ApplicationController
  def home
    @diaspora_group = Group.find_by_id(194)
    @blag_group = Group.find_by_id(1031)
    @loomio_community_group = Group.find_by_id(3)
  end

  def about
  end

  def blog
  end

  def crowdfunding_celebration
  end

  def privacy
  end

  def services
  end

  def pricing
  end

  def terms_of_service
  end

  def third_parties
    @parties = [
      {name: 'Amazon S3',
       description: 'stores uploaded files and images.',
       link: "http://www.amazon.com/gp/help/customer/display.html?nodeId=468496" },

      {name: "Cloudflare",
       link: "http://www.cloudflare.com/security-policy",
       description: 'Caches web content for faster page loads. Cloudflare and the rest of the internet backbone carry pages when requested. these are encrypted end to end.'},

      {name: "Heroku",
       link: "https://www.heroku.com/policy/privacy",
       description: 'Host the Loomio software. They provide the servers we use to run Loomio.org'},

      {name: "New Relic",
       link: "http://newrelic.com/privacy",
       description: "New relic monitors application performance metrics"},

      {name: 'Facebook',
       link: "https://www.facebook.com/about/privacy/",
       description: 'to allow you to login via your Facebook account.'},

      {name: "Google",
       link: "http://www.google.com/policies/privacy/",
       description: 'we use Google to log in via your Google account. Optionally you can authorize us to download your Google contacts when inviting people to your group.'}
    ]
  end

  def translation
  end
end
