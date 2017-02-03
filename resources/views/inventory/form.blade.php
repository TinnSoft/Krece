
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
                                 label="measure_unit">
                                 <span slot="noResult">Oops! No se han encontrado registros coincidentes.
                                 </span>
                                 </multiselect>                       
                            </td>                 
                        </tr>	
                         <tr> 
                            <td><small>Cantidad inicial</small><a class="text-danger"><strong> *</strong></a></td>
                            <td>  
                                <span>                              
                                    <input type="number" class="form-control" v-model="form.inv_quantity_initial">   
                                </span>                           
                            </td>                 
                        </tr>	
                         <tr> 
                            <td><small>Precio de compra</small><a class="text-danger"><strong> *</strong></a></td>
                            <td>  
                                <span>                              
                                    <input type="number" class="form-control" v-model="form.inv_unit_cost">   
                                </span>                           
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

   <div class="modal inmodal fade" id="categoryModal" tabindex="-1" role="dialog"  aria-hidden="true">
     <div class="modal-dialog modal-sm">
           <div class="modal-content animated fadeIn">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title">@{{header_modal}}</h4>                                            
                 </div>
                <div class="modal-body">
                    <div class="form-group"><label><a class="text-danger"><strong>* </strong></a>Nombre:</label> <input type="text" 
                        v-model="category.name" placeholder="Categoria" class="form-control">
                    </div>
                    <div class="form-group"><label>Descripción:</label> <input type="text" 
                        v-model="category.description" placeholder="Descripción" class="form-control">
                    </div>
                    <div class="form-group"><label>Cuenta NIIF:</label> <input type="text" 
                        v-model="category.niif_account" placeholder="# de cuenta" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancelar</button>
                    
                    <template v-if="category.name === ''">
                        <button type="button" class="btn btn-primary disabled">Guardar</button>
                    </template>
                    <template v-else>
                        <button type="button" @click="Modal_click_save()" class="btn btn-primary">Guardar</button>
                    </template>                            
                </div>
            </div>
    </div>
 </div>

