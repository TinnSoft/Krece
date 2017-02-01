
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
                        <input type="text" class="form-control" v-model="form.name"></text>
                        <span v-if="errors.name" class="error is-danger  text-danger">
                           Ingresa un nombre de retención
                        </span>   </span>                           
                    </td>                 
				</tr>
                <tr>
					<th><span >Porcentaje</span></th>
					<td>
                        <span id="prefix1" ></span>
                        <span>
                            <input type="number" class="form-control" v-model="form.value"></text>
                            <span v-if="errors.value" class="error is-danger  text-danger">
                           Ingresa un porcentaje de Retención
                        </span>   </span>       
                        </span>
                    </td>
				</tr>
				<tr>
					<th><span >Tipo de Retención</span></th>
					<td>
                       
                        <span>                        
                             <multiselect 
                            :options="retention" 
                            v-model="form.retention_type"
                            label="name"         
                            track-by="name"
                            placeholder="Retención..."    
                            @input="onInputretention"                        
                        >
                        </multiselect>
                        </span>
                            <span v-if="errors.type_id" class="error is-danger  text-danger">
                            Seleccione un tipo de retención válido
                            </span>   
                        </span> 
                    </td>
				</tr>
                <tr>
                    <th><span>Descripción</span></th>
                    <td><span>
                        <textarea class="form-control has-icon has-icon-right form-control" v-model="form.description"></textarea> 
                       </span>     
                    </td>
                </tr>
			</table>
        </div> 

        
        
    </div> 




