# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PropertyType.create([
  { name: 'Single Family', created_by: 0, verified: true }, 
  { name: 'Multi Family', created_by: 0, verified: true }, 
  { name: 'Condo', created_by: 0, verified: true }
])

BuildingType.create([
  { name: 'Main House', created_by: 0, verified: true }, 
  { name: 'Shed', created_by: 0, verified: true },
  { name: 'Garage', created_by: 0, verified: true }, 
  { name: 'Barn', created_by: 0, verified: true }, 
  { name: 'Pool House', created_by: 0, verified: true}
])

ConstructionStyle.create([
  { name: 'Colonial', created_by: 0, verified: true }, 
  { name: 'Cape', created_by: 0, verified: true }, 
  { name: 'Ranch', created_by: 0, verified: true }, 
  { name: 'Tudor', created_by: 0, verified: true }, 
  { name: 'Saltbox', created_by: 0, verified: true }, 
  { name: 'Split Level', created_by: 0, verified: true }, 
  { name: 'Multi Level', created_by: 0, verified: true }
])
  
ConstructionType.create([
  { name: 'Brick', created_by: 0, verified: true }, 
  { name: 'Wood Frame', created_by: 0, verified: true }, 
  { name: 'Prefab', created_by: 0, verified: true }
])
  
HeatType.create([
  { name: 'Forced Hot Air', created_by: 0, verified: true }, 
  { name: 'Baseboard', created_by: 0, verified: true }, 
  { name: 'Radiant', created_by: 0, verified: true }, 
  { name: 'None', created_by: 0, verified: true}
])
  
HeatSource.create([
  { name: 'Oil', created_by: 0, verified: true }, 
  { name: 'Gas', created_by: 0, verified: true }, 
  { name: 'Propane', created_by: 0, verified: true }, 
  { name: 'None', created_by: 0, verified: true }
])
  
AreaType.create([
  { name: 'Kitchen', created_by: 0, verified: true }, 
  { name: 'Bathroom', created_by: 0, verified: true }, 
  { name: 'Bedroom', created_by: 0, verified: true }, 
  { name: 'Family Room', created_by: 0, verified: true }, 
  { name: 'Living Room', created_by: 0, verified: true }, 
  { name: 'Dining Room', created_by: 0, verified: true }, 
  { name: 'Great Room', created_by: 0, verified: true },
  { name: 'Office', created_by: 0, verified: true },
  { name: 'Playroom', created_by: 0, verified: true },
  { name: 'Basement', created_by: 0, verified: true },
  { name: 'Attic', created_by: 0, verified: true },
  { name: 'Closet', created_by: 0, verified: true },
  { name: 'Sun Room', created_by: 0, verified: true },
  { name: 'Deck', created_by: 0, verified: true },
  { name: 'Front Yard', created_by: 0, verified: true },
  { name: 'Back Yard', created_by: 0, verified: true }
])

PaintManufacturer.create([
  { name: 'Benjamin Moore', created_by: 0, verified: true },
  { name: 'Valspar', created_by: 0, verified: true },
  { name: 'Olympia', created_by: 0, verified: true}
])

PaintType.create([
  { name: 'Interior', created_by: 0, verified: true },
  { name: 'Exterior', created_by: 0, verified: true },
  { name: 'Interior/Exterior', created_by: 0, verified: true },
  { name: 'Stain', created_by: 0, verified: true},
  { name: 'Sealant', created_by: 0, verified: true }
])

ApplianceType.create([
  { name: 'Oven', created_by: 0, verified: true },
  { name: 'Dishwasher', created_by: 0, verified: true },
  { name: 'Microwave', created_by: 0, verified: true },
  { name: 'Refridgerator', created_by: 0, verified: true },
  { name: 'Stove Top', created_by: 0, verified: true },
  { name: 'Compactor', created_by: 0, verified: true },
  { name: 'Boiler', created_by: 0, verified: true },
  { name: 'Furnace', created_by: 0, verified: true },
  { name: 'Central Air', created_by: 0, verified: true },
  { name: 'Washing Machine', created_by: 0, verified: true },
  { name: 'Dryer', created_by: 0, verified: true },
])

ApplianceManufacturer.create([
  { name: 'Whirlpool', created_by: 0, verified: true },
  { name: 'GE', created_by: 0, verified: true },
  { name: 'Kenmore', created_by: 0, verified: true },
  { name: 'KitchenAid', created_by: 0, verified: true },
  { name: 'LG', created_by: 0, verified: true },
  { name: 'Samsung', created_by: 0, verified: true },
  { name: 'Bosch', created_by: 0, verified: true }
])

ContractorType.create([
  { name: 'Plumbing', created_by: 0, verified: true },
  { name: 'Carpentry', created_by: 0, verified: true },
  { name: 'Electrical', created_by: 0, verified: true },
  { name: 'HVAC', created_by: 0, verified: true }, 
  { name: 'Landscaping', created_by: 0, verified: true },
  { name: 'Masonry', created_by: 0, verified: true },
  { name: 'Painting', created_by: 0, verified: true }
])

Contractor.create([
  { name: 'Homeowner', created_by: 0, verified: true }
])

MaintenanceCycle.create([
  { name: 'Days' }, 
  { name: 'Weeks' }, 
  { name: 'Months' }, 
  { name: 'Years'} 
])

MaintenanceType.create([
  { name: 'Septic Service', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Gutter Cleanout', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Seal Driveway', interval: 2, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Water Filter', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Smoke Detectors', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Water Softener', interval: 6, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Months').first.id, created_by: 0, verified: true },
  { name: 'Sweep Chimney', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Lawn - Aerate', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Lawn - Overseed', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Lawn - Fertilize', interval: 3, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Months').first.id, created_by: 0, verified: true },
  { name: 'HVAC Filter', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Sprinkler System - Open', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true },
  { name: 'Sprinkler System - Winterize', interval: 1, maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id, created_by: 0, verified: true }
])

ProjectType.create([
  { name: 'Addition', created_by: 0, verified: true },
  { name: 'Remodel', created_by: 0, verified: true },
  { name: 'Paint', created_by: 0, verified: true },
  { name: 'Window Replacement', created_by: 0, verified: true },
  { name: 'Door Replacement', created_by: 0, verified: true }
])

ProjectStatus.create([
  { name: 'To Do' },
  { name: 'Planning' },
  { name: 'In Progress' },
  { name: 'Completed' }
])

InventoryItemType.create([
  { name: 'Electronics', created_by: 0, verified: true },
  { name: 'Furniture', created_by: 0, verified: true },
  { name: 'Clothes', created_by: 0, verified: true },
  { name: 'Collectibles', created_by: 0, verified: true },
  { name: 'Toys', created_by: 0, verified: true }
])
