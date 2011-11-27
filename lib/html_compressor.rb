class HtmlCompressor
  def initialize(app)
    @app = app
  end
  
  def call(env)
    status, headers, response = @app.call(env)
    
    if env == "production" && headers['Content-Type'] && headers['Content-Type'].match(/text\/html/i)
    
      # remove any whitespace at the beginning of the line
      body = response.body.gsub(/^\s*/, '')
    
      # strip javascript comments that are the beginning of the line
      body = body.gsub(/^\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\//, '').gsub(/^\/\/(.*)?/, '')
      
      # strip whitespace, new line, html comments
      body = body.gsub(/(\n|\t|\r)/, ' ').gsub(/>\s*</, '><').gsub(/<!--[^>]*-->/, ' ').squeeze(' ')
      
      headers['Content-Length'] = body.length.to_s
      response.body = body
    end
      
    [status, headers, response]
  end
end
