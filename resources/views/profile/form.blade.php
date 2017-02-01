
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
					<td>        
                        <input type="text" class="form-control" v-model="form.name"></text> 
                         <span v-if="errors.name" class="error is-danger  text-danger">
                            Ingresa un valor aquí
                            </span>  
                    </td>                 
				</tr>
                <tr>
					<th><span >Apellido</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.last_name"></text>
                            <span v-if="errors.last_name" class="error is-danger  text-danger">
                            Ingresa un valor aquí
                            </span>   
                        </span>
                    </td>
				</tr>

                <tr>
					<th><span >email</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.email"></text>
                            <span v-if="errors.email" class="error is-danger  text-danger">
                            Ingresa un valor aquí
                            </span>   
                        </span>
                    </td>
				</tr>
				
              
			</table>
        </div> 
    </div> 




