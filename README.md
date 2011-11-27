HtmlCompressor Middleware
================

This middleware strips out all html whitespace & comments and javascript comments of the document. It doesn't remove any html conditional comments. It modifies only for the html response in the production environment.

The way it does by modifying html response using regular expression. To make regular expression work unobtrusively, you should place javascript comments in a new seperate line, otherwise it won't strip out.

Usage
=======
In your config/application.rb file add:

    config.middleware.use "HtmlCompressor"
