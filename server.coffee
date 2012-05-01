http = require 'http'
querystring = require 'querystring'
Filter = require('./filter').Filter
port = process.env.PORT || 4567

help = """
  Submit a POST the string you want to filter.

  A response of `true` means you're all clean, `false` means you've got a potty mouth.

  Examples:
  curl -d "this is a really dirty string" filthy.herokuapp.com
  curl -d "{'content':'this is a super dirty string'}" filthy.herokuapp.com
  curl -d "content=this is the dirtiest of strings" filthy.herokuapp.com
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
      if @data and @data.content
        res.end Filter.isClean(@data.content)
      else if @data
        for key of @data
          if key.length > 0
            res.end Filter.isClean(key)
          else
            value = @data[key]
            res.end Filter.isClean(value)
      else
        res.end help
  else
    res.end help
.listen(port, '0.0.0.0')
