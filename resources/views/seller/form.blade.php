
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
                        <input type="text" class="form-control" v-model="form.name">
                        <span v-if="errors.name" class="error is-danger  text-danger">
                           Ingresa el nombre del vendedor
                        </span>   </span>                           
                    </td>                 
				</tr>
                <tr>
					<th><span >Número de identificación</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.dni">                                
                        </span>
                    </td>
				</tr>
				<tr>
					<th><span >Observaciones</span></th>
					<td>                       
                        <span>
                            <textarea class="form-control" v-model="form.observations"> </textarea>                             
                        </span>
                    </td>
				</tr>
                <tr>
                   <th><span >Número de teléfono de trabajo</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.work_phone">                                
                        </span>
                    </td>
                </tr>
                <tr>
                   <th><span >Número de teléfono privado</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.private_phone">                                
                        </span>
                    </td>
                </tr>
			</table>
        </div> 
        
    </div> 




