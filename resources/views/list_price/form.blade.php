
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
					<th><span >Nombre</span></th>
					<td>                       
                        <span>
                            <input type="text" class="form-control" v-model="form.name"></input>
                        </span>
                        <template v-if="form.name===''">  
                            <span v-if="errors.name" class="error is-danger  text-danger">
                            Debe especificar un nombre válido.
                            </span>
                        </template>
                    </td>
				</tr>
				<tr>
					<th><span>Tipo</span></th>
					<td>                       
                        <span>                            
                           <input type="radio" id="percentaje" value="1" v-model="form.type_id">
                            <label for="p">Porcentaje</label>
                            <br>
                           <input type="radio" id="value" value="2" v-model="form.type_id">
                            <label for="v">Valor</label>                            
                        </span>
                        <br>
                        <template v-if="form.type_id===''">                        
                            <span v-if="errors.type_id" class="error is-danger  text-danger">
                            Seleccione un tipo de precio.
                            </span>
                        </template>
                    </td>
				</tr>               
                <tr>
                    <template v-if="form.type_id === '1'">
                    <th><span >Porcentaje %</span></th>
                        <td>                       
                            <span>                        
                                <input type="number" class="form-control" v-model="form.value">                          
                            </span>
                        </td>
                    </template>                
					
				</tr>
			</table>
        </div> 
    </div> 
 <div class="hr-line-dashed"></div>
