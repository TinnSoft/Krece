
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>


    <div class="row">        
        <div class="col-lg-5">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><span>Nombre</span></th>
					<td>  <span>            
                        <input type="text" class="form-control input-sm" v-model="form.name">
                        <span v-if="errors.name" class="error is-danger  text-danger">
                           Ingresa un nombre de impuesto
                        </span>   </span>                           
                    </td>                 
				</tr>
                <tr>
					<th><span >Porcentaje</span></th>
					<td>
                        <span id="prefix1" ></span>
                        <span>
                            <input type="number" class="form-control input-sm" v-model="form.amount">
                            <span v-if="errors.amount" class="error is-danger  text-danger">
                           Ingresa un porcentaje de impuesto
                        </span>   
                        </span>
                    </td>
				</tr>
				<tr>
					<th><span >Tipo de impuesto</span></th>
					<td>
                       
                        <span>                        
                             <multiselect 
                            :options="taxes" 
                            v-model="form.tax_type"
                            label="name"         
                            track-by="name"
                            placeholder="Impuesto..."    
                            :show-labels="false"
                            @input="onInputTax"                        
                        >
                        </multiselect>
                        </span>
                            <span v-if="errors.type_id" class="error is-danger  text-danger">
                            Seleccione un tipo de impuesto válido
                            </span>   
                       
                    </td>
				</tr>
                <tr>
                    <th><span>Descripción</span></th>
                    <td><span>
                        <textarea class="form-control has-icon has-icon-right" v-model="form.description"></textarea> 
                       </span>     
                    </td>
                </tr>
			</table>
        </div> 

        
        
    </div> 




