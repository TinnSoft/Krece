
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
					<th style="width: 10em"><small>Nombre</small></th>
					<td>  <span>            
                        <input type="text" class="form-control input-sm" v-model="form.name"></text>         
                    </td>                 
				</tr>
                <tr>
					<th><small >Días</small></th>
					<td>
                        <span id="prefix1" ></span>
                        <span>
                            <input type="number" class="form-control input-sm" v-model="form.days"></text>
                            <span v-if="errors.days" class="error is-danger  text-danger">
                           Ingresa un valor aquí
                        </span>   </span>       
                        </span>
                    </td>
				</tr>
				
              
			</table>
        </div> 

        
        
    </div> 




