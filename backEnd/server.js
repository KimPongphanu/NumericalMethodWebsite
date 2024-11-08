const express = require('express');
const mysql = require('mysql');
const cors = require('cors'); // เพิ่มการนำเข้า cors
const app = express();
const port = 3000;

app.use(cors());


const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'numerical'
});

db.connect(err => {
  if (err) {
    throw err;
  }
  console.log('Connected to MySQL');
});

app.get('/api/chapters', (req, res) => {
  const sql = 'SELECT id, chapter FROM lesson';
  db.query(sql, (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(result);
  });
});

app.get('/api/methods',(req,res) =>{
  const sql = 'SELECT method , chapter FROM method';
  db.query(sql,(err,result) =>{
    if(err){
      return res.status(500).send(err);
    }
    res.json(result);
  })
})



app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
