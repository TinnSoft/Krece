
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
					<th style="width: 10em"><small>Tipo de Cuenta</small></th>
					<td>  <span>  
                    
                          <multiselect 
                            :options="bank_account" 
                            v-model="form.bank_account"
                            label="description"         
                            track-by="description"
                            placeholder="Tipo de cuenta" 
                            @input="onInputType"
                        >
                        </multiselect>

                        <small v-if="errors.bank_account_type_id" class="error is-danger  text-danger">
                           Debe especificar un tipo de cuenta válido.
                        </small>                             
                    </td>                 
				</tr>
                <tr>
					<th><small >Nombre de la cuenta</small></th>
					<td>                       
                        <small>
                            <input type="text" class="form-control input-sm" v-model="form.bank_account_name"></input>
                        </small>
                        <small v-if="errors.bank_account_name" class="error is-danger  text-danger">
                           Debe especificar un nombre de cuenta válido.
                        </small>
                    </td>
				</tr>
				<tr>
					<th><small >Número de la cuenta</small></th>
					<td>                       
                        <span>
                        
                            <input type="text" class="form-control input-sm" 
                            v-model="form.bank_account_number"></input> 
                            
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Saldo Inicial</small></th>
					<td>                       
                        <span>
                        
                            <input type="number" class="form-control input-sm" 
                            v-model="form.initial_balance"></input> 
                             <small v-if="errors.initial_balance" class="error is-danger  text-danger">
                                Debe especificar un valor para el balance válido.
                            </small>
                        </span>
                    </td>
				</tr>
                <tr>
					<th><small >Descripción</small></th>
					<td>                       
                        <span>                        
                            <textarea class="form-control" v-model="form.description"></textarea>                             
                        </span>
                    </td>
				</tr>
			</table>
        </div> 

      
    </div> 
 <div class="hr-line-dashed"></div>


<!--
<pre><code>@{{$data | json}}</code></pre>
-->
