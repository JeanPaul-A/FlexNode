document.addEventListener('DOMContentLoaded', function () {
    const txtInput = document.getElementById('txtInput');
    const btnSubmit = document.getElementById('btnSubmit');
    const btnReset = document.getElementById('btnReset');
    const txtOutput = document.getElementById('txtOutput');

    const txtParams = document.getElementById('txtParams');

    const btnCirculo = document.getElementById('btnCirculo');
    const btnCuadrado = document.getElementById('btnCuadrado');
    const btnRectangulo = document.getElementById('btnRectangulo');
    const btnTriangulo = document.getElementById('btnTriangulo');
    const btnTrapecio = document.getElementById('btnTrapecio');

    btnCirculo.addEventListener('click', function () {
        txtParams.textContent = "Radio";
        txtInput.value = "Circulo()"
        txtOutput.value = "";
    })
    btnCuadrado.addEventListener('click', function () {
        txtParams.textContent = "Lado";
        txtInput.value = "Cuadrado()";
        txtOutput.value = "";
    })
    btnRectangulo.addEventListener('click', function () {
        txtParams.textContent = "Base y altura";
        txtInput.value = "Rectangulo()";
        txtOutput.value = "";
    })
    btnTriangulo.addEventListener('click', function () {
        txtParams.textContent = "Base y altura";
        txtInput.value = "Triangulo()";
        txtOutput.value = "";
    })
    btnTrapecio.addEventListener('click', function () {
        txtParams.textContent = "Base mayor, menor y altura";
        txtInput.value = "Trapecio()";
        txtOutput.value = "";
    })

    //FLex
    btnSubmit.addEventListener('click', function () {
        const texto = txtInput.value;

        //Envía el texto al servidor
        fetch('/analizar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ texto: texto })
        })
            .then(response => response.text())
            .then(data => {
                txtOutput.value = data;
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });

    btnReset.addEventListener('click', function () {
        txtInput.value = "";
        txtParams.textContent = "Parámetros";
        btnCirculo.checked = false;
        btnCuadrado.checked = false;
        btnRectangulo.checked = false;
        btnTriangulo.checked = false;
        btnTrapecio.checked = false;
    })
});
