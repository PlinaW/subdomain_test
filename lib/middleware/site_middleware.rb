class SiteMiddleware
  # def initialize(app)
  #   @app = app
  # end

  # def call(env)
  #   request = Rack::Request.new(env)
  #   subdomain = request.host.split(".").first
  #   site = Site.find_by(subdomain: subdomain)

  #   if site
  #     #   [ 302, { "Location" => "lvh.me:3000" }, [ "Site not found" ] ]
  #     # else
  #     env["current_site"] = site
  #     @app.call(env)
  #   end
  # end

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    subdomain = request.host.split(".").first

    if subdomain.present?
      # Przykład: znajdź site po subdomenie
      @current_site = Site.find_by(subdomain: subdomain)

      if @current_site.nil?
        # Jeśli site nie istnieje, przekieruj do głównej domeny
        return [ 302, { "Location" => "lvh.me:3000", "Content-Type" => "text/html" }, [] ]
      end
    end

    # Ustaw @current_site w requestu, jeśli jest potrzebne
    env["current_site"] = @current_site

    @app.call(env)
  end
end
