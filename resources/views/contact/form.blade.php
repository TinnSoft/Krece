
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>


{!!Html::style('/css/style_tables.css')!!}


    <div class="row">        
        <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><span>Nombre</span></th>
					<td>  
                        <span>                              
                            <input type="text" class="form-control" v-model="form.name">    
                            <span v-if="errors.name" class="error is-danger  text-danger">
                                Adiciona un nombre válido
                            </span>   
                        </span>                           
                    </td>                 
				</tr>
                <tr>
					<th><span >NIT</span></th>
					<td>                       
                        <span>
                           <input type="text" class="form-control" v-model="form.nit">  
                        </span>
                    </td>
				</tr>
				<tr>
					<th><span >Dirección</span></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.address">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Ciudad</span></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.city">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Email</span></th>
					<td>
                        <span>
                           <input type="email" class="form-control" v-model="form.email">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Teléfono 1</span></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.phone1">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Teléfono 2</span></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.phone2">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Fax</span></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.fax">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Celular</span></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.phone_mobile">  
                        </span>
                    </td>
				</tr>
			</table>
        </div> 

         <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><span>Lista de precios</span></th>
					<td>
                         <span>
                            <multiselect 
                                :options="listPrice" 
                                v-model="form.list_price"
                                label="name"         
                                track-by="name"
                                placeholder="Seleccione..."
                                @input="onInputlistprice"
                            >
                            </multiselect>
                        </span>
                    </td>                 
				</tr>
               
				<tr>
					<th><span >Vendedor</span></th>
					<td>
                        <span>                     
                             <multiselect 
                                :options="sellers" 
                                v-model="form.seller"
                                label="name"         
                                track-by="name"
                                placeholder="Seleccione..."
                                 @input="onInputSeller"
                            >
                            </multiselect>

                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Terminos de pago</span></th>
					<td>                        
                         <multiselect 
                                :options="paymentterms" 
                                v-model="form.payment_terms"
                                label="name"         
                                track-by="name"
                                placeholder="Seleccione..."
                                @input="onInputPaymentT"
                            >
                            </multiselect>

                    </td>
				</tr>
                <tr>
					<th><span >Cliente</span></th>
					<td>
                         <input type="checkbox" value="" v-model="form.isCustomer"></label> <label class="checkbox-inline">
                          
                    </td>
				</tr>
                <tr>
					<th><span >Proveedor</span></th>
					<td>
                         <input type="checkbox" value="" v-model="form.isProvider"></label> <label class="checkbox-inline">
                          
                    </td>
				</tr>
                 <tr>
					<th><span >Observaciones</span></th>
					<td>
                         <textarea v-model="form.observation" class="form-control"></textarea>
                          
                    </td>
				</tr>
			</table>
            
        </div> 
        
    </div> 
 <div class="hr-line-dashed"></div>

<table class="table-hover">
    <thead>
        <tr>
            <th style="width: 2em"> </th>
            <th style="width: 2em">Nombre</th>
             <th>Apellido</th>
            <th>Correo Eléctrónico</th>
            <th>Teléfono</th>
            <th>Celular</th>
            <th>Notificar? <i class="fa fa-info-circle fa-1x green" data-toggle="tooltip" data-placement="right"
            title="Marque esta opción solo si requiere que esta persona reciba correos con alertas sobre facturas disponibles y/o vencidas"></i></th>
        </tr>
    </thead>
       
    <tbody>
        
        
        <tr  v-for="_contact_others in form.contact_others">                       
            <td style="width: 1em">
              
                <a @click="removeItem(_contact_others)">
                    <span id="icon-detail" class="fa fa-remove fa-2x" style="color:red">
                    </span>
                </a>
            </td>           
            <td style="width: 10em" class="form-product_id"  >
                     <input type="text" class="form-control"  v-model="_contact_others.name"> 
            </td>     
            <td style="width: 10em" >
                <input type="text" class="form-control" v-model="_contact_others.last_name">
            </td>
            <td style="width: 8em">
                <input type="email" class="form-control"  v-model="_contact_others.email">
            </td>
            <td  style="width: 7em">
                <input type="text" class="form-control " v-model="_contact_others.phone">
            </td>            
            <td  style="width: 7em">
                <input type="text" class="form-control " v-model="_contact_others.phone_mobile">
            </td>
             <td  style="width: 2em; text-align:center;">                
                <input type="checkbox" value="" class="" v-model="_contact_others.notify"></label> <label class="checkbox-inline">
                 
            </td>
        </tr>        
    </tbody>
    
</table>


 <template id="mtemplate">
</template>


<table class="table2">
		<tr>
			<button  class="btn btn-primary btn-xs btn-outline" type="button"  
            @click="addLine" ><i class="fa fa-user"></i>&nbsp;Asociar persona
            </button>		
		</tr>
</table>

<pre><code>@{{$data.errors | json}}</code></pre>

<!--

<pre><code>@{{$data | json}}</code></pre>
-->

