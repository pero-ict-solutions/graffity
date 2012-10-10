Graffity
============

Gem that adds a sidebar with the current view stack of your Spree webshop. That way it is very easy to find the correct virtual paths to override, but it also shows all the current Deface overrides.

It's still a spike right now and not complete yet, but could be usefull.

Feel free to fork and submit pull requests!

Installation
=======

In your Gemfile:

    gem 'graffity', :git => 'git://github.com/pero-ict-solutions/graffity.git', :group => :development

Then run from the command line:

    $ bundle install

Finally, make sure to **restart your app**. Navigate to *http://localhost:3000/_graffity* and you should see a toggle button to open up a side panel with the current view stack.

Copyright (c) 2012 PeRo ICT Solutions, released under the New BSD License