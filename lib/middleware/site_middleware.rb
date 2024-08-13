class SiteMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    subdomain = request.host.split(".").first

    if subdomain.present?
      @current_site = Site.find_by(subdomain: subdomain)
    end

    env["current_site"] = @current_site

    @app.call(env)
  end
end
