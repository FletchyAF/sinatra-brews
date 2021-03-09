require './config/environment'

use Rack::MethodOverride
use UsersController
use BrewsController
run ApplicationController