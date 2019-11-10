const express = require('express');
const cors = require('cors');
const compression = require('compression');
const path = require('path');

const appFolder = path.join(__dirname, '../views');

const app = express();
app.use(compression());
app.use(cors());

app.get('*.*', express.static(appFolder, { maxAge: '1y' }));

app.all('*', (req, res) => {
  res.status(200).sendFile(`/`, { root: appFolder });
});

app.listen(3000, () => {
  console.log('Listening on 3000');
});