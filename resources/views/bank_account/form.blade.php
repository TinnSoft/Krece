
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
					<th style="width: 10em"><span>Tipo de Cuenta</span></th>
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

                        <span v-if="errors.bank_account_type" class="error is-danger  text-danger">
                           Debe especificar un tipo de cuenta válido.
                        </span>                             
                    </td>                 
				</tr>
                <tr>
					<th><span >Nombre de la cuenta</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.bank_account_name"></input>
                        </span>
                        <span v-if="errors.bank_account_name" class="error is-danger  text-danger">
                           Debe especificar un nombre de cuenta válido.
                        </span>
                    </td>
				</tr>
				<tr>
					<th><span >Número de la cuenta</span></th>
					<td>                       
                        <span>
                        
                            <input type="text" class="form-control" 
                            v-model="form.bank_account_number"></input> 
                            
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Saldo Inicial</span></th>
					<td>                       
                        <span>
                        
                            <input type="number" class="form-control" 
                            v-model="form.initial_balance"></input> 
                             <span v-if="errors.initial_balance" class="error is-danger  text-danger">
                                Debe especificar un valor para el balance válido.
                            </span>
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Descripción</span></th>
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
