Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://assisttech-web.onrender.com', 'http://localhost:3001' , 'https://frontend-web-five-sigma.vercel.app'
    resource '/api/*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end
end

