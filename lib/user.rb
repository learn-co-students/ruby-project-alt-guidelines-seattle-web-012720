class User < ActiveRecord::Base
    has_one :order
end