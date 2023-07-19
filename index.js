const { spawn } = require('child_process');
const path = require('path');

const flexProcess = spawn('flex', [path.join(__dirname, 'lex/project.l')]);

flexProcess.on('exit', (code) => {
  if (code === 0) {
    console.log('Archivo "project.l" compilado exitosamente');
  } else {
    console.error('Error al compilar el archivo "project.l"');
  }
});

const lexProcess = spawn('gcc', ['-o', 'lex.yy', path.join(__dirname, 'lex.yy.c')]);

lexProcess.on('exit', (code) => {
  if (code === 0) {
    console.log('Archivo "lex.yy" compilado exitosamente');
    iniciarServidor();
  } else {
    console.error('Error al compilar el archivo "lex.yy.c"');
  }
});

function iniciarServidor() {
  const express = require('express');
  const app = express();
  const port = 3000;

  app.use(express.static('public'));
  app.use(express.json());

  app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
  });

  app.post('/analizar', (req, res) => {
    const texto = req.body.texto;

    const lexProcess = spawn('./lex.yy');

    lexProcess.stdin.write(`${texto}\n`);
    lexProcess.stdin.end();

    let salida;
    lexProcess.stdout.on('data', (data) => {
      salida = data.toString();
    });

    lexProcess.on('close', (close) => {
      res.send(salida);
    });
  });
}
