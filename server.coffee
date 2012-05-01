http = require 'http'
querystring = require 'querystring' 
Filter = require('./filter').Filter
port = process.env.PORT || 4567

help = """
  Submit a POST with `content` set to the string you want to filter.

  A response of `true` means you're all clean, `false` means you've got a potty mouth.
"""

http.createServer (req, res)->
  req.setEncoding 'utf8'
  res.writeHead 200, {'Content-Type': 'text/plain'}
  if req.method is 'POST'
    req.on 'data', (data)->
      try
        if req.headers['content-type'].indexOf('application/json') > -1
          @data = JSON.parse data
        else
          @data = querystring.parse(data)
      catch error
        res.end help
    req.on 'end', ()->
      console.log @data if @data
      if @data and @data.content
        res.end Filter.isClean(@data.content)
      else if @data and @data['']
        res.end Filter.isClean(@data[''])
      else
        res.end help
  else
    res.end help
.listen(port, '0.0.0.0')
