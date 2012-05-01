http = require 'http'
Filter = require('./filter').Filter
port = process.env.PORT || 4567

http.createServer (req, res)->
  req.setEncoding 'utf8'
  res.writeHead 200, {'Content-Type': 'text/plain'}
  if req.method is 'POST'
    req.on 'data', (data)->
      @data = JSON.parse data
    req.on 'end', ()->
      res.end Filter.isClean(@data.content)
  else
    res.end """
      Submit a POST with `content` set to the string you want to filter.

      A response of `true` means you're all clean, `false` means you've got a foul mouth.
    """
.listen(port, '127.0.0.1')
