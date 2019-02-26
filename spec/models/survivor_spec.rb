require 'rails_helper'

RSpec.describe Survivor, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:water) }
  it { should validate_presence_of(:medication) }
  it { should validate_presence_of(:food) }
  it { should validate_presence_of(:ammunition) }
  
end
