Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://techassist-ggaa.onrender.com', 'http://localhost:3001'
    resource '/api/*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end
end

