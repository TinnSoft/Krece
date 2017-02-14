
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>


<link href="/css/style_tables.css" rel="stylesheet">

        <div class="row">
            <div class="col-lg-5">
                 <h2>COTIZACIÓN No: @{{form.resolution_id}}</h2>
            </div>
            <div class="col-lg-5 text-right">
                 <span> MONTO </span>
                            <h2 v-cloak class="font-bold">@{{grandTotal | formatCurrency}} COP</h2>                            
            </div>               
        </div>


     <div class="hr-line-dashed"></div>



    <div class="row">        
        <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><span>Cliente</span><a class="text-danger"><strong> *</strong></a></th>
					<td>  <span>  
                     
                          <multiselect 
                            :options="customer_list" 
                            v-model="form.contact"
                            label="name"         
                            track-by="name"
                            placeholder="Seleccione..." 
                            @input="onInputContact"
                             :allow-empty="false"
                        >
                        </multiselect>

                        <span v-if="errors.customer_id" class="error is-danger  text-danger">
                            Olvidaste seleccionar un cliente.
                        </span>   </span>                           
                    </td>                 
				</tr>
                <tr>
					<th><span >Observaciones</span></th>
					<td>
                        <span id="prefix1" ></span>
                        <span>
                            <textarea class="form-control" v-model="form.observations"></textarea>
                        </span>
                    </td>
				</tr>
				<tr>
					<th><span >Notas de la cotización</span><a class="text-danger"><strong> *</strong></a></th>
					<td>
                        <span id="prefix2" ></span>
                        <span>
                        
                            <textarea class="form-control has-icon has-icon-right form-control" placeholder="Estas notas no serán visibles en la cotización" v-model="form.notes"></textarea> 
                            
                        </span>
                         <span v-if="errors.notes" class="error is-danger  text-danger">
                            No olvides ingresar una nota aquí.
                        </span>   </span> 

                    </td>
				</tr>
			</table>
        </div> 

         <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><span>Fecha</span><a class="text-danger"><strong> *</strong></a></th>
					<td>
                        <span >                        
                             <datepicker-vue class="form-control" 
                                v-model="form.date" 
                                value='@{{form.date }}'>
                             </datepicker-vue>
                                             
                            <span v-if="errors.date" class="error is-danger  text-danger">
                            Ingrese una fecha para la cotización</span>  
                        </span>
                    </td>                 
				</tr>
                <tr>
					<th><span >Vencimiento</span><a class="text-danger"><strong> *</strong></a></th>
					<td><span id="prefix" ></span>
                        <span>
                           
                            <div class="form-group" >
                            <datepicker-vue class="form-control" 
                                v-model="form.due_date" 
                                value='@{{form.due_date}}' 
                                >
                             </datepicker-vue>
                            </div>
                            <span v-if="errors.due_date" class="error is-danger  text-danger">
                            Adiciona una fecha final</span>  
                        </span>
                    </td>
				</tr>

				<tr>
					<th><span >Vendedor</span></th>
					<td>
                        <span>
                             <multiselect 
                                :options="vendors" 
                                v-model="form.seller"
                                label="name"         
                                track-by="name"
                                placeholder="Seleccione..."
                                @input="onInputSeller"
                                :show-labels="false"
                            >
                            </multiselect>

                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Lista de precios</span></th>
					<td>
                        <span id="prefix" ></span>                      
                      
                         <multiselect 
                                :options="listPrice" 
                                v-model="form.list_price"
                                label="name"         
                                track-by="name"
                                placeholder="Seleccione..."
                                @input="onInputlistprice"
                                :show-labels="false"
                            >
                            </multiselect>

                    </td>
				</tr>
                <tr>
					<th><span >Moneda</span></th>
					<td>
                      
                         <multiselect 
                                :options="currency" 
                                v-model="form.currency"
                                label="code"         
                                track-by="code"
                                placeholder="Seleccione..."
                                :custom-label="currencyLabel"
                                @input="onInputCurrency"
                                :show-labels="false"
                            >
                            </multiselect>
                           

                    </td>
				</tr>
			</table>
            
        </div> 
        
    </div> 
<small>los campos marcados como <a class="text-danger"><strong> *</strong></a> son obligatorios</small>

<table class="table-hover">
    <thead>
        <tr>
         
            <th style="width: 2em">PRODUCTO</th>
             <th>DESCRIPCIÓN</th>
            <th>PRECIO</th>
            <th>CANTIDAD</th>
            <th>DESC %</th>
            <th>IMPUESTO %</th>           
            <th colspan="2">TOTAL</th>
        </tr>
    </thead>
       
    <tbody>
        
        
        <tr id="Icon-m" title="Remover ítem" v-for="_detail in form.detail">                       
              
            <td style="width: 18em" class="form-product_id"  >
               <span> 
                    <multiselect 
                            :options="product_list" 
                            class="input_number"
                            v-model="_detail.product"
                            label="name"         
                            track-by="name"
                            placeholder="Buscar ítem..." 
                            @input="onInputProduct(_detail)"
                        >
                        </multiselect>


                </span>  
            </td>     
            <td class="form-description" style="width: 10em" >
                <textarea rows="1" class="form-control input_number" v-model="_detail.description"></textarea>
            </td>
            <td class="form-unit_price" style="width: 8em">
                <input type="number" class="form-control input_number"  v-model.number="_detail.unit_price">
            </td>
            <td class="form-quantity"  style="width: 7em">
                <input type="number" class="form-control input_number" v-model.number="_detail.quantity">
            </td>            
            <td class="form-discount" style="width: 5em">
                <input type="number" class="form-control input_number" v-model.number="_detail.discount">
            </td>
            <td class="form-tax"  style="width: 5em">
                  <multiselect 
                            :options="taxes" 
                            v-model="_detail.tax_value"
                            label="text"         
                            track-by="value"
                            placeholder="Impuesto"
                            ShowLabels="false"
                            @input="onInputTax(_detail)"
                            :show-labels="false"
                        >
                        </multiselect>

            </td>
            <td class="form-total" style="width: 7em" >
                <span class="form-number">@{{_detail.quantity * _detail.unit_price - (_detail.quantity * _detail.unit_price*_detail.discount/100)  | formatCurrency}}</span>
            </td>
             <td style="width: 1em">
              
                <a @click="removeItem(_detail)">
                    <span id="icon-detail" class="fa fa-remove fa-2x" style="color:red">
                    </span>
                </a>
            </td>        
        </tr>        
    </tbody>
    
</table>


 <template id="mtemplate">
</template>


<table class="table2">
		<tr>
			<button  class="btn btn-primary btn-xs btn-outline" type="button"  
            @click="addLine" ><i class="fa fa-plus"></i>&nbsp;Nueva línea
            </button>		
		</tr>
</table>

  <div v-if="errors.products_empty" class="alert alert-danger">      
     Debe ingresar por lo menos un producto en la cotización
 </div>


<table class="balance">
                <tr>
					<th><span >Sub-Total</span></th>
					<td><span data-prefix></span><span>@{{subTotal | formatCurrency}}</span></td>
				</tr>
				<tr>
					<th><span >Descuentos</span></th>
					<td><span data-prefix></span><span >@{{DiscountsTotal | formatCurrency}}</span></td>
				</tr>
                <tr>
					<th><span >Impuestos</span></th>
					<td><span data-prefix></span><span>@{{TaxesTotal | formatCurrency}}</span></td>
				</tr>
				<tr>
					<th><span >Total</span></th>
					<td><span data-prefix></span><span>@{{grandTotal | formatCurrency}}</span></td>
				</tr>  
              
                               
</table>
<!--

<pre><code>@{{$data.form | json}}</code></pre>
-->




