class OwnersController < ApplicationController
  include Tapir

  api(:mobile) do
    allow_all_actions
  end
end
