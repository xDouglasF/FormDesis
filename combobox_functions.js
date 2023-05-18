window.addEventListener('DOMContentLoaded', () => {
    rellenarRegiones()
    rellenarCandidatos()
});

var formulario = document.getElementById('Formulario');
var regiones = document.querySelector('#region');
var comunas = document.querySelector('#comuna');
var candidatos = document.querySelector('#candidato');


//Obtener y rellenar select de regiones
const obtenerRegiones = async () => {
    try{
        const response = await fetch('http://localhost:3000/regiones.php',{
            method: 'GET',
            mode: 'cors'
        })
        return response.json();
    } catch(error){
        console.log(error);
    }
}

const rellenarRegiones = () => {
    obtenerRegiones()
    .then(data => {
        for (let i in data){
            regiones.innerHTML+=`<option value=${data[i].idregion}>${data[i].region}</option>`;
        }
    })
}



//Obtener y rellenar select de candidatos
const obtenerCandidatos = async () => {
    try{
        const response = await fetch('http://localhost:3000/candidatos.php',{
            method: 'GET',
            mode: 'cors'
        })
        return response.json();
    }catch(error){
        console.log(error);
    }
}

const rellenarCandidatos = () => {
    obtenerCandidatos()
    .then(data => {
        for (let i in data){
            candidatos.innerHTML+=`<option value=${data[i].idcandidato}>${data[i].candidato}</option>`;
        }
    })
}



//Obtener y rellenar select de comunas
regiones.addEventListener('change', (e) => {
    //Aqui necesito el idregion para solo mostrar las comunas que pertenecen a la región seleccionada por el usuario
    let idregion = e.target.value;
    if(idregion!=0){
        let form = new FormData()
        form.append('idregion', idregion) //Paso el idregion como parametro para que php pueda consultar las comunas de una región en especifico
        fetch('http://localhost:3000/comunas.php',{
            method: 'POST',
            body: form
        })
        .then((res) => res.json())
        .then(data => {
            comunas.innerHTML=`<option value=0>-</option>`
            for (let i in data){ //En caso de tener la respuesta, la recorremos y añadimos al select comunas para que muestre todas las comunas de la región
                comunas.innerHTML+=`<option value=${data[i].idcomuna}>${data[i].comuna}</option>`;
            }
        })
    }else{
        comunas.innerHTML=`<option value=0>-</option>` //En caso de que se vuelva a seleccionar la region con value=0
    }
})