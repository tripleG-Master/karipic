// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require rails-ujs
//= require_tree .

import Rails from '@rails/ujs';
Rails.start();

import "@hotwired/turbo-rails"
import "controllers"
