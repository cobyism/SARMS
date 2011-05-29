# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SARMS::Application.initialize!


Time::DATE_FORMATS[:unit] = "%A, %B %d, %Y"

require 'will_paginate'