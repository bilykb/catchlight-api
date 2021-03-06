const router = require('express').Router();
const { authenticateToken } = require('../middleware/authorization');

module.exports = db => {

  /* GET home page. */
  router.post('/', authenticateToken, async function(req, res, next) {

    try {
      //Get user2 id from email and user 1 from body
      const query = `SELECT id FROM users WHERE email = $1`
      queryParams1 = [req.body.email]
      const { rows } = await db.query(query, queryParams1)
      const userId1 = req.user.id;
      const userId2 = rows[0].id;
      
      //Insert friendship into database
      queryParams2= [userId1, userId2];
      const query2= `INSERT INTO friends (sending_user_id, recieving_user_id) VALUES ($1, $2) returning *`
      const friendReq = await db.query(query2, queryParams2);
      res.send('friend request made')

    } catch(error) {
      res.send({"error": error.detail})
    }
    
  });

  //Get friend reqs for a specific user
  router.get('/requests', authenticateToken, async function(req, res, next) {
    try {
      const query = `SELECT friends.id, sending_user_id, users.name, users.email, users.profile_picture
      FROM friends JOIN users ON users.id = friends.sending_user_id 
      WHERE friends.friendship_pending = true AND friends.recieving_user_id = $1`
      queryParams = [req.user.id];
      const friendRequests = await db.query(query, queryParams)
      res.send(friendRequests.rows)
    } catch(error) {
      res.send({"error": error.detail})
    }
    
  });

  router.put('/requests', authenticateToken, async function(req, res, next) {

    try {
      //query to change friendship status to true or false
      const query = `UPDATE friends SET friendship = $1, friendship_pending = false WHERE id = $2 returning *`
      queryParams = [req.body.friendResponse, req.body.id]
      const friendRow = await db.query(query, queryParams)
      res.send("friend action complete");

    } catch(error) {
      res.send({"error": error.detail})
    }
  });

  return router;
};
