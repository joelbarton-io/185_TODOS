require "pg"

class DatabasePersistence
  def initialize(logger)
    @logger = logger
    @db = if Sinatra::Base.production?
      PG.connect(ENV['DATABASE_URL'])
    else
      PG.connect(dbname: "todos")
    end
  end

  def disconnect
    @db.close
  end

=begin all_lists
  - create sql to fetch all tuples from `lists` table
  - execute query; -> PG::result object

  - traverse PG::result object, passing block the current tuple
    - get current value of `list_id`
    - pass `list_id` to `find_todo_for_list` method
    <-- hash object with list info & array of todo hashes
=end

  def all_lists
    lists_sql =
    <<~SQL
    SELECT lists.*,
      COUNT(todos.id) AS todos_count,
      COUNT(NULLIF(todos.completed, true)) AS todos_remaining_count
      FROM lists
      LEFT JOIN todos ON lists.id = todos.list_id
      GROUP BY lists.id
      ORDER BY lists.name;
    SQL
    list_result = query(lists_sql)

    list_result.map do |tuple|
      tuple_to_list_hash(tuple)
    end
  end

=begin find_list
  - create sql statement to fetch all tuples from `lists` with method param `id` as their id
  - execute query; -> PG::result object

  - traverse PG::result
    - get current value of `list_id`
    - pass `list_id` to `find_todo_for_list` method
    <-- hash object with list info & array of todo hashes
=end

  def find_list(id)
    list_sql =
    <<~SQL
    SELECT lists.*,
        COUNT(todos.id) AS todos_count,
        COUNT(NULLIF(todos.completed, true)) AS todos_remaining_count
        FROM lists
        LEFT JOIN todos ON lists.id = todos.list_id
        WHERE lists.id = $1
        GROUP BY lists.id
        ORDER BY lists.name;
    SQL
    list_result = query(list_sql, id)
    tuple = list_result.first
    tuple_to_list_hash(tuple)
  end

  def tuple_to_list_hash(tuple)
    {
      id: tuple["id"].to_i,
      name: tuple["name"],
      todos_count: tuple["todos_count"].to_i,
      todos_remaining_count: tuple["todos_remaining_count"].to_i
    }
  end

  def to_boolean(str)
    str == "t"
  end

  def create_new_list(list_name)
    sql = "INSERT INTO lists (name) VALUES ($1)"
    query(sql, list_name)
  end

  def delete_list(id)
    sql = "DELETE FROM lists WHERE id = $1"
    query(sql, id)
  end

  def update_list_name(id, new_name)
    sql = "UPDATE lists SET name = $1 WHERE id = $2"
    query(sql, new_name, id)
  end

  def create_new_todo(list_id, todo_name)
    sql = "INSERT INTO todos (list_id, name) VALUES ($1, $2)"
    query(sql, list_id, todo_name)
  end

  def delete_todo_from_list(list_id, todo_id)
    sql = "DELETE FROM todos WHERE list_id = $1 AND id = $2"
    query(sql, list_id, todo_id)
  end

  def update_todo_status(list_id, todo_id, new_status)
    sql = "UPDATE todos SET completed = $3 WHERE list_id = $1 AND id = $2"
    query(sql, list_id, todo_id, new_status)
  end

  def mark_all_todos_as_completed(list_id)
    sql = "UPDATE todos SET completed = true WHERE list_id = $1"
    query(sql, list_id)
  end

=begin find_todo_for_list
  - traverse PG::result object (ARRAY OF HASHES)
    - create a PG::result object containing all `todos` whose `list_id` matches the `id` of the current value of block argument `list_tuple`, store in `todos_result`

    - traverse `todos_result`
      - for each `todo_tuple`, block returns a hash object containing tuple data
    - return hash object containing `list_tuple` id, name, and todos data
=end

  def find_todo_for_list(list_id)
    todos_sql = "SELECT * FROM todos WHERE list_id = $1"
    todos_result = query(todos_sql, list_id)

    todos_result.map do |todo_tuple|
      { id: todo_tuple["id"].to_i,
        name: todo_tuple["name"],
        completed: to_boolean(todo_tuple["completed"]) }
    end
  end

  private

  def query(statement, *params)
    @logger.info("#{statement} #{params}")
    @db.exec_params(statement, params)
  end
end
