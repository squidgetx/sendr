### Endpoints

`GET /scoresheet/climbs` - Retrieve list of climbs given by the current scoresheet

`GET /comps/:id/leaders` - Get the leaders for the comp id

`GET /scoresheet/scores` - gets the scores for the current scoresheet

`PUT /scoresheet/speed` - Adds a new speed record (in `params[:time]`) to the current scoresheet

`PUT /comps/:id/join` - The current user joins comp with id `:id`.

`GET /comps` - Returns an array of open comps

`GET /comps/:id` - Returns an array of the top scores in boulder, speed, and sport climbers for the comp `:id`

`POST /comps` - Creates a new competition with parameters given in `params[:comp]`

`PATCH /comps/:id` - Updates the comp with id `:id` with parameters given in `params[:comp]`

`PUT /climbers/login` - Logs in the user with CCS id given in `params[:ccs_id]`

`GET /climbers` - Returns an array of all the climbers

`POST /climbers` - Create new climber with params in `params[:climber]`

`PATCH /climbers/:id` - Update climber `:id` with params in `params[:climber]`

`PUT /routes/:id/send` - Record a send for the route `:id` in the current scoresheet. Returns the updated `climb` scoresheet entry.

`PUT /routes/:id/attempt` - Record an attempt for the route `:id` in the current scoresheet. Returns the updated `climb` scoresheet entry

`PUT /routes/:id/witness` - Record the witness (in `params[:witness]`) for the route `:id` in the current scoresheet. Returns the updated `climb` scoresheet entry

`POST /routes` - Create new route with params in `params[:route]`

`PATCH /routes/:id` - Update route `:id` with params in `params[:route]`

`
