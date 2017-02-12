
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>

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
                                Adiciona un nombre de ítem válido
                            </small>   
                        </span>                           
                    </td>                 
				</tr>
                <tr>
					<td><span >Referencia</span></td>
					<td>                       
                        <span>
                           <input type="text" class="form-control" v-model="form.reference">  
                        </span>
                    </td>
				</tr>
				               
                <tr> 
					 <td><span >Descripción</span></td>
					<td>
                        <span>
                           <textarea class="form-control" v-model="form.description"></textarea>  
                        </span>
                    </td>
				</tr>   
                <tr>
					<td><span >Precio de venta</span><a class="text-danger"><strong> *</strong></a></td>
					<td>
                        <span>
                           <input type="number" class="form-control" v-model="form.sale_price"> 
                            <template v-if="toUseListPrice == false">
                                 <p><a class="text-info" @click="toggleLListPrice" ><span class="fa fa-plus-circle"></span><small>  Usar lista de precios</small></a> </p>
                            </template>
                            <template v-else>
                                 <p><a class="text-danger" @click="toggleLListPrice"><span class="fa fa-times-circle"></span><small> Quitar lista de precios</small></a> </p>
                            </template>
                            <small v-if="errors.sale_price" class="error is-danger  text-danger">
                                Debe ingresar un precio de venta
                            </small>   
                        </span>
                    </td>
				</tr>
                 <tr>
                 <template v-if="toUseListPrice == true">
                        <td style="width: 10em"><span>Lista de precios</span><a class="text-danger"><strong> *</strong></a></td>
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
                    </template>    
				</tr>            
               
			</table>
        </div> 

         <div class="col-lg-5">
            <table class="table table-responsive">	
				<tr>
					<td><span >Impuesto</span><a class="text-danger"><strong> *</strong></a></td>
					<td>
                        <span>                     
                             <multiselect 
                                :options="taxes" 
                                v-model="form.tax"
                                label="name"         
                                track-by="name"
                                placeholder="Seleccione..."
                                 @input="onInputTax"
                            >
                            </multiselect>
                             <small v-if="errors.tax_id" class="error is-danger  text-danger">
                                Selecciona un impuesto
                            </small>   
                        </span>
                    </td>
				</tr>
               <tr>
					<td><span >Item inventariable?</span></td>
					<td>
                        <span>                     
                             <span>
                           <input type="checkbox" value="1" v-model="form.inv_inStock">  
                        </span>

                        </span>
                    </td>
				</tr>               
			</table>            

              <div  v-if="form.inv_inStock=='1'" class="grid" >
                <div class="grid-item">                      
                    <h5>DETALLE DE INVENTARIO</h5>
                    <table class="table">
                        <tr> 
                            <td><small>Unidad de medida</small><a class="text-danger"><strong> *</strong></a></td>
                            <td>  
                                 <multiselect 
                                 v-model="form.measure_unit" 
                                 :options="measure_unit"                                 
                                 group-values="measure" 
                                 group-label="measure_type" 
                                 placeholder="Seleccione.." 
                                 track-by="measure_unit" 
                                 @input="onInputUnitMeasure"
                                 label="measure_unit">
                                 <span slot="noResult">Oops! No se han encontrado registros coincidentes.
                                 </span>
                                 </multiselect>     
                                 <small v-if="errors.inv_type_id" class="error is-danger  text-danger">
                                    Selecciona una unidad de medida
                                </small>                     
                            </td>                 
                        </tr>	
                         <tr> 
                            <td><small>Cantidad inicial</small><a class="text-danger"><strong> *</strong></a></td>
                            <td>  
                                <span>                              
                                    <input type="number" class="form-control" v-model="form.inv_quantity_initial">  
                                    <small v-if="errors.inv_quantity_initial" class="error is-danger  text-danger">
                                    La cantidad inicial debe ser mayor a 0
                                </small>         
                                </span>                           
                            </td>                 
                        </tr>	
                         <tr> 
                            <td><small>Precio de compra</small><a class="text-danger"><strong> *</strong></a></td>
                            <td>  
                                <span>                              
                                    <input type="number" class="form-control" v-model="form.inv_unit_cost">   
                                </span> 
                                <small v-if="errors.inv_unit_cost" class="error is-danger  text-danger">
                                    El precio de compra debe ser mayor a 0
                                </small>                                   
                            </td>                 
                        </tr>		
                    </table>
                    </div> 
                </div>                
        </div> 
    </div> 
        <div class="panel-body">        
            <div class="ibox-content">                                
                @include('inventory.category-grid')
                 <div v-if="errors.category_id" class="alert alert-danger">      
                    Debe seleccionar una <strong>categoría</strong> antes de continuar
                </div>             
            </div>  
        </div>  

   @include('partials.category_modal')

<pre>@{{$data.form}}</pre>