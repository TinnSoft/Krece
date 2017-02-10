
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}


</style>

<link href="/css/style_tables.css" rel="stylesheet">
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row">        
        <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<td style="width: 10em"><span>Nombre</span><a class="text-danger"><strong> *</strong></a></td>
					<td>  
                        <span>                              
                            <input type="text" class="form-control" v-model="form.name">    
                            <small v-if="errors.name" class="error is-danger  text-danger">
                                Adiciona un nombre válido
                            </small>   
                        </span>                           
                    </td>                 
				</tr>
                <tr>
					<td><span >Numeración automática</span></td>
					<td>                       
                        <span>
                            <label> <input type="checkbox" v-model="form.auto_increment"> </label>
                        </span>
                    </td>
				</tr>
				<template v-if="form.auto_increment=='1'">           
                <tr> 
					 <td><span >Prefijo</span></td>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.prefix"></input>  
                        </span>
                    </td>
				</tr>   
               <tr> 
					<td style="width: 10em"><span>Número inicial</span><a class="text-danger"><strong> *</strong></a></td>
					<td>  
                        <span>                              
                            <input type="text" class="form-control" v-model="form.initial_number">    
                            <small v-if="errors.initial_number" class="error is-danger  text-danger">
                                Debe adicionar un número inicial
                            </small>   
                        </span>                           
                    </td>                 
				</tr>
                 <tr> 
					 <td><span >Número final</span></td>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.final_number"></input>  
                        </span>
                    </td>
				</tr>  
                </template>
                <tr> 
					 <td><span >Preferida:</span></td>
					<td>
                        <span>
                            <body>
                                  <input type="radio" id="percentaje" value="1" v-model="form.isDefault">
                                    <label for="p">Si</label>
                                    <br>
                                <input type="radio" id="value" value="0" v-model="form.isDefault">
                                    <label for="v">No</label>   
                            </body>
                        
                        </span>
                    </td>
				</tr>  
                <tr> 
					 <td><span >Resolución:</span></td>
					<td>
                        <span>
                           <textarea class="form-control" v-model="form.invoice_text" 
                           placeholder="Ejemplo: Resolución Facturación por computador No 12345678 de 2017/01/01 Rango del 1 al 2000">
                           </textarea>  
                        </span>
                    </td>
				</tr>  
               
			</table>
        </div> 
