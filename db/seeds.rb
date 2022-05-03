# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

CarriageType.create(name: "First-class", description:"First-class carriage with 9 rows with 4 sleeping seats placed in 2 floors.", capacity: 36)
CarriageType.create(name: "Second-class", description:"Second-class carriage with 9 rows with 6 sleeping seats placed in 2 floors.", capacity: 54)

# Add stations with connections