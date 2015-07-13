require 'intact_case/version'
require 'intact_case/modules'

String.send :include, StewEucen::Acts::IntactCase::String
Array .send :include, StewEucen::Acts::IntactCase::Array
