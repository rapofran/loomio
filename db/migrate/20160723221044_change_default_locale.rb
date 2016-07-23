class ChangeDefaultLocale < ActiveRecord::Migration
  def change
    User.where(selected_locale: ['es',nil]).each do |user|
      user.update_attribute :selected_locale, 'es-ahr'
    end
  end
end
