Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins  %r{\Ahttps://techassist\.[a-z]+\z}
    resource '/api/*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end
end

