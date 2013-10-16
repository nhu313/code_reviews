require 'q/services/factory'
require 'q/services/db'

Q::Services::Factory.db_service = Q::Services::DB
Q::Services::Factory.models = Models.map
