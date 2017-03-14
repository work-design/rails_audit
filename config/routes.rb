Rails.application.routes.draw do

  scope module: 'admin', path: ':auditable_type/:auditable_id' do
    resources :audits, only: ['index']
  end

end
