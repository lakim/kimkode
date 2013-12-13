# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-full
# Or use the 'minimal' variant:
#FROM phusion/passenger-minimal:<VERSION>

# Set correct environment variables.
ENV HOME /root

# Remove authentication rights for insecure_key.
RUN rm -f /root/.ssh/authorized_keys /home/*/.ssh/authorized_keys

# If you're using the 'minimal' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
# RUN /build/utilities.sh
#   Ruby support.
#/build/ruby1.8.sh
#/build/ruby1.9.sh
#/build/ruby2.0.sh
#   Common development headers necessary for many Ruby gems,
#   e.g. libxml for Nokogiri.
# RUN /build/devheaders.sh
#   Python support.
#/build/python.sh
#   Node.js and Meteor support.
#/build/nodejs.sh

# Fix passenger install
RUN cd /tmp && /usr/bin/ruby2.0 '/usr/share/passenger/ruby_extension_source/extconf.rb' && make install

# Add deploy user
RUN adduser deploy --no-create-home --uid 1111 --disabled-password --gecos ""

# Nginx
ADD config/nginx.conf /etc/nginx/
ADD config/louisalbankim.conf /etc/nginx/sites-enabled/
ADD runit/nginx /etc/service/nginx/run
RUN rm /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD louisalbankim.sh /sbin/
CMD ["/sbin/louisalbankim.sh"]
