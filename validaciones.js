var formulario = document.getElementById('Formulario');
var inputs = document.querySelectorAll('#Formulario input');

//Obtengo los select para posteriormente poder validar los options
var selectRegion = document.getElementById('region');
var selectComuna = document.getElementById('comuna');
var selectCandidato = document.getElementById('candidato');

let checkConocio=""; //Lo ocupare para juntar todos los checkboxes en un solo string

//Para más facilidad se puede validar nombre, alias y correo con expresiones regulares
const expresiones = {
	nombre: /^[a-zA-ZÀ-ÿ\s]+$/,
    alias: /^[a-zA-Z0-9\_\-]{5,}$/,
	correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/
};

//Con esto puedo controlar si todas las validaciones estan correctas para poder enviar el formulario
const campos = {
    'nombre': false,
    'alias': false,
    'rut': false,
    'email': false,
    'region': false,
    'comuna': false,
    'candidato': false,
    'conocio': false
};

//Metodo para validar que los checkboxs son 2 o más y los guardo todos juntos en la variable checkConocio
const validarCheckbox = () =>{
    const checksValidos = document.querySelectorAll('input[type=checkbox]:checked');
    if(checksValidos.length<2){
        return false;
    }
    checkConocio="";
    for (let i = 0; i < checksValidos.length;i++){
        if(i+1==checksValidos.length){
            checkConocio += checksValidos[i].value;
        }else{
            checkConocio += checksValidos[i].value +", ";
        }
    }
    return true;
};

//Metodo que valida el rut junto a dv (digito verificador)
const validarRut = (rutCompleto) =>{
    rutCompleto = rutCompleto.replace("‐","-");
    if (!/^[0-9]+[-|‐]{1}[0-9kK]{1}$/.test(rutCompleto))
        return false;
    var tmp 	= rutCompleto.split('-');
    var digv	= tmp[1];
    var rut 	= tmp[0];
    if ( digv == 'K' ) digv = 'k' ;
    return (dv(rut) == digv );
};

const dv = (T) => {
    var M=0,S=1;
    for(;T;T=Math.floor(T/10))
        S=(S+T%10*(9-M++%6))%11;
    return S?S-1:'k';
};

//Metodo para validar si la region seleccionada no es la que tiene value=0
const validarRegion = () =>{
    let indice = selectRegion.selectedIndex;
    let opcionSeleccionada = selectRegion[indice];
    if(opcionSeleccionada.value>0){
        idregion=opcionSeleccionada.value;
        campos['region']=true;
    }else{
        campos['region']=false;
    }
}

//Metodo para validar si la comuna seleccionada no es la que tiene value=0
const validarComuna = () =>{
    let indice = selectComuna.selectedIndex;
    let opcionSeleccionada = selectComuna[indice];
    if(opcionSeleccionada.value>0){
        idcomuna=opcionSeleccionada.value;
        campos['comuna']=true;
    }else{
        campos['comuna']=false;
    }
}

//Metodo para validar si el candidato seleccionado no es el que tiene value=0
const validarCandidato = () =>{
    let indice = selectCandidato.selectedIndex;
    let opcionSeleccionada = selectCandidato[indice];
    if(opcionSeleccionada.value>0){
        idcandidato=opcionSeleccionada.value;
        campos['candidato']=true;
    }else{
        campos['candidato']=false;
    }
}

//Case para validar cada input según name para luego llamar la validación correspondiente
const validarInput = (e) => {
    switch (e.target.name){
        case "nombre":
            if(expresiones.nombre.test(e.target.value)){
                campos['nombre']=true;
            }else{
                campos['nombre']=false;
            }
        break;
        case "alias":
            if(expresiones.alias.test(e.target.value)){
                campos['alias']=true;
            }else{
                campos['alias']=false;
            }
        break;
        case "rut":
            if (validarRut(e.target.value)){
                campos['rut']=true;
            } else {
                campos['rut']=false;
            }
        break;
        case "email":
            if(expresiones.correo.test(e.target.value)){
                campos['email']=true;
            }else{
                campos['email']=false;
            }
        break;
        case "checkbox":
            if(validarCheckbox()){
                campos['conocio']=true;
            }else{
                campos['conocio']=false;
            }
    }
};

//Poner a los selects en escucha para saber cuando una opción es seleccionada y poder validarla
selectRegion.addEventListener('change',validarRegion);
selectComuna.addEventListener('change',validarComuna);
selectCandidato.addEventListener('change',validarCandidato);

//Poner a todos los input en escucha cuando se levanta una tecla o cuando se hace click fuera del input para poder validarlos
inputs.forEach((input) => {
    input.addEventListener('keyup', validarInput);
    input.addEventListener('blur',validarInput);
});

//Poner el formulario en escucha para saber cuando se presiona el boton "voto" que intenta enviar el formulario al sistema
formulario.addEventListener('submit', (e) => {
    e.preventDefault();
    //Si todos los campos cumplen con las validaciones quiere decir que esta permitido el voto
    if(campos.nombre && campos.alias && campos.rut && campos.email && campos.region && campos.comuna && campos.candidato && campos.conocio){
        var datos = new FormData(formulario);
        datos.append('checkboxs',checkConocio)//Añado los checkboxes como un solo string
        fetch('http://localhost:3000/ingresarVoto.php',{
            method:'POST', //Detallo que el metodo es POST
            body: datos //Y le paso datos que es el form data creado anteriormente con todos los datos validados
        })
        .then(res => res.json())
        .then(data => {
            console.log(data); //Y finalmente escribo por consola que sucedio con la query, si ingreso o no ingreso.
            formulario.reset(); //Reseteo todos los valores del formulario
        })
    }
});