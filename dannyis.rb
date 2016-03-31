module DannyIs
  class App < Sinatra::Base
    use Rack::MethodOverride # Required for put delete etc
    helpers Sinatra::ContentFor

    # -------------------------- CONFIG ------------------------- #

    configure :development do
      require 'better_errors'
      use BetterErrors::Middleware
      BetterErrors.application_root = __dir__
    end

    configure :production do
      require 'newrelic_rpm'
    end

    configure do
      Article.configure do |config|
        config.articles_path = '../articles'
        config.draft_articles_path = '../articles/drafts'
        config.images_path = '../public/article-images'
        config.articles_per_page = 2
        config.development_mode = true if ENV['RACK_ENV'] == 'development'
      end
    end

    before do
      # Switch on Caching
      cache_control :public, :must_revalidate, max_age: 60 if ENV['RACK_ENV'] == 'production'
    end

    # --------------------- Simple Redirects ------------------- #


    get '/graming/?' do redirect 'http://instagram.com/dannysmith' end
    get '/noting/?' do redirect 'http://notes.danny.is' end
    get '/tweeting/?' do redirect 'http://twitter.com/dannysmith' end
    get '/colophon/?' do redirect '/styleguide' end


    # ------------------------ Site Pages ---------------------- #

    get '/' do
      erb :home
    end

    get '/singing/?' do
      erb :singing
    end

    get '/teaching/?' do
      erb :teaching
    end

    get '/reading/?' do
      erb :reading
    end

    get '/coding/?' do
      erb :coding
    end

    get '/designing/?' do
      erb :designing
    end

    get '/drawing/?' do
      erb :drawing
    end

    get '/snapping/?' do
      erb :snapping
    end

    get '/spending/?' do
      erb :spending
    end

    get '/styleguide/?' do
      erb :styleguide
    end

    # ----------------------------- Blog --------------------------- #


    get '/writing/?' do
      @articles = Article.published
      erb :writing
    end

    # -------------------------- RSS Feeds ------------------------ #

    get '/feed/?' do
      # @articles = Article.published
      builder :feed
    end

    # ------------------------- JSON Routes ----------------------- #

    # get '/articles.json' do
    # end

    # get '/articles/:post.json' do
    # end

    # -------------------------- Redirects ------------------------ #

    get // do
      path = request.path_info
      case path
      when %r{^/cv(?:/|\.pdf)?$}
        puts "Redirecting to CV"
        redirect 'http://files.dasmith.co.uk/cv.pdf', 301
      when /^\/files(.*)/
        puts "Redirecting to http://files.dasmith.co.uk/files#{$1}"
        redirect "http://files.dasmith.co.uk/files#{$1}", 301
      else
        puts "Trying redirect to CloudApp: #{path}"
        # Try a redirect to CloudApp
        if [200, 301].include? Net::HTTP.get_response("c.danny.is", path).code.to_i
          puts "Redirecting to CloudApp"
          redirect "http://c.danny.is#{path}"
        else
          puts "No CloudApp resource found"
          status 404
          erb :e404
        end
      end
    end

    not_found do
      status 404
      erb :e404
    end

  end
end
