
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>


{!!Html::style('/css/style_tables.css')!!}
{!!Html::style('/themes/krece/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css')!!}


    <div class="row">        
        <div class="col-lg-5">
            <table class="table table-responsive" >				
				<tr> 
					<th style="width: 10em"><small>Nombre</small></th>
					<td>                  
                            <input type="text" class="form-control input-sm" v-model="form.name">    
                            <small v-if="errors.name" class="error is-danger  text-danger">
                                Adiciona un nombre válido
                            </small>            
                    </td>                 
				</tr>
                <tr>
					<th><small >NIT</small></th>
					<td>                       
                        <small>
                           <input type="text" class="form-control input-sm" v-model="form.nit">  
                        </small>
                    </td>
				</tr>
				<tr>
					<th><small >Dirección</small></th>
					<td>
                        <span>
                           <input type="text" class="form-control input-sm" v-model="form.address">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Ciudad</small></th>
					<td>
                        <span>
                           <input type="text" class="form-control input-sm" v-model="form.city">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Email</small></th>
					<td>
                        <span>
                           <input type="email" class="form-control input-sm" v-model="form.email">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Teléfono 1</small></th>
					<td>
                        <span>
                           <input type="text" class="form-control input-sm" v-model="form.phone1">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Teléfono 2</small></th>
					<td>
                        <span>
                           <input type="text" class="form-control input-sm" v-model="form.phone2">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Fax</small></th>
					<td>
                        <span>
                           <input type="text" class="form-control input-sm" v-model="form.fax">  
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Celular</small></th>
					<td>
                        <span>
                           <input type="text" class="form-control input-sm" v-model="form.phone_mobile">  
                        </span>
                    </td>
				</tr>
			</table>
        </div> 

         <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><small>Lista de precios</small></th>
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
					<th><small >Vendedor</small></th>
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
					<th><small >Terminos de pago</small></th>
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
					<th><small >Cliente</small></th>
					<td>
                        <div class="checkbox checkbox-success">
                         <input type="checkbox" class="styled" value="" v-model="form.isCustomer"> <label class="checkbox-inline">
                        </div>
                    </td>
				</tr>
                <tr>
					<th><small >Proveedor</small></th>
					<td>
                        <div class="checkbox checkbox-success">
                         <input type="checkbox" class="styled" value="" v-model="form.isProvider"> <label class="checkbox-inline">
                         </div>  
                    </td>
				</tr>
                 <tr>
					<th><small >Observaciones</small></th>
					<td>
                         <textarea v-model="form.observation" class="form-control input-sm"></textarea>
                          
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
                     <input type="text" class="form-control input-sm"  v-model="_contact_others.name"> 
            </td>     
            <td style="width: 10em" >
                <input type="text" class="form-control input-sm" v-model="_contact_others.last_name">
            </td>
            <td style="width: 8em">
                <input type="email" class="form-control input-sm"  v-model="_contact_others.email">
            </td>
            <td  style="width: 7em">
                <input type="text" class="form-control input-sm " v-model="_contact_others.phone">
            </td>            
            <td  style="width: 7em">
                <input type="text" class="form-control input-sm " v-model="_contact_others.phone_mobile">
            </td>
             <td  style="width: 2em; text-align:center;">   
                 <div class="checkbox checkbox-success">             
                    <input type="checkbox" value="" class="styled" v-model="_contact_others.notify"> <label class="checkbox-inline"></label>
                 </div>  
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

