
<style>
[v-cloak] {
  display: none;
}
</style>


<link href="/css/style_tables.css" rel="stylesheet">

        <div class="row">
            <div class="col-lg-5">
                 <h2>Factura No: @{{form.resolution_id}}</h2>
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
					<th style="width: 10em"><span>Proveedor</span><a class="text-danger"><strong> *</strong></a></th>
					<td>  <span>  
                     
                          <multiselect 
                            :options="customer_list" 
                            v-model="form.contact"
                            label="name"         
                            track-by="name"
                            placeholder="Seleccione..." 
                            @input="onInputContact"
                        >
                        </multiselect>

                        <small v-if="errors.customer_id" class="error is-danger  text-danger">
                            Olvidaste seleccionar un proveedor.
                        </small>   </span>                           
                    </td>                 
				</tr>
               
                 <tr>
					<th><span >Observaciones</span></th>
					<td>
                        <span id="prefix1" ></span>
                        <span>
                            <textarea class="form-control"
                            v-model="form.observations"></textarea>
                        </span>
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
                                             
                            <small v-if="errors.date" class="error is-danger  text-danger">
                            Ingrese una fecha para la factura de venta</small>  
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
                            <small v-if="errors.due_date" class="error is-danger  text-danger">
                            Adiciona una fecha final</small>  
                        </span>
                    </td>
				</tr>
				
                <tr>
					<th><span >Moneda</span></th>
					<td>
                      
                      <multiselect 
                                v-model="form.currency" 
                                deselect-label="quitar" 
                                track-by="code" 
                                label="code" 
                                placeholder="Seleccione..." 
                                :options="currency" 
                                :show-labels="false"
                                :allow-empty="false"
                                @input="onInputCurrency">
                            </multiselect>
                       
                    </td>
				</tr>
			</table>
            
        </div> 
        
    </div> 
<small>los campos marcados con <a class="text-danger"><strong> *</strong></a> son obligatorios</small>

<table class="table-hover">
    <thead>
        <tr>           
            <th >CATEGORÍA</th>
            <th>DESCRIPCIÓN</th>
            <th>PRECIO</th>
            <th>CANTIDAD</th>
            <th>DESC %</th>
            <th>IMPUESTO</th>           
            <th colspan="2">TOTAL</th>
        </tr>
    </thead>
       
    <tbody>
        
        
        <tr id="Icon-m" title="Remover ítem" v-for="_detail in form.detail">                       
                
            <td style="width: 16em" class="form-category_id"  >
               <span> 
                         <multiselect 
                                v-model='_detail.category' 
                                :options='product_list' 
                                :multiple='false' 
                                group-values='detail'
                                group-label='name' 
                                placeholder='Buscar ítem...' 
                                track-by='name' 
                                label='name'
                                :show-labels='false'
                                 @input='onInputProduct(_detail)'>                                
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
                            v-model="_detail.taxes"
                            label="text"         
                            track-by="value"
                            placeholder="Impuesto"
                            :show-labels="false"
                            @input="onInputTax(_detail)"
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

  <div v-if="errors.detail" class="alert alert-danger">      
     Debe seleccionar por lo menos una categoría
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


