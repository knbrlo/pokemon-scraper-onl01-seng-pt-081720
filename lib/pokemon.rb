class Pokemon

# The Pokemon class (lib/pokemon.rb) is responsible for saving, adding, removing, or changing anything about each Pokémon.
# It should be handed "raw" Pokémon data from the scraper and handle the ORM work to put the data into the database. It's probably most appropriate to
# Create any methods you think you need to make working with the Pokémon data easier.
# Notice that #initialize requires keyword arguments. (https://stackoverflow.com/questions/15062570/when-to-use-keyword-arguments-aka-named-parameters-in-ruby)
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(pokemon_hash)
        @id = pokemon_hash[:id]
        @name = pokemon_hash[:name]
        @type = pokemon_hash[:type]
        @db = pokemon_hash[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?
        SQL
        pokemon_from_db = db.execute(sql, id)[0]
        custom_pokemon_hash = {}
        custom_pokemon_hash[:id] = pokemon_from_db[0]
        custom_pokemon_hash[:name] = pokemon_from_db[1]
        custom_pokemon_hash[:type] = pokemon_from_db[2]
        custom_pokemon_hash[:db] = db
        new_pokemon_instance = self.new(custom_pokemon_hash)
    end
end
