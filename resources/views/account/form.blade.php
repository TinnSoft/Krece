
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>

 {!!Html::style('/themes/krece/css/plugins/jasny/jasny-bootstrap.min.css')!!}    
 {!!Html::script('/themes/krece/js/plugins/jasny/jasny-bootstrap.min.js')!!}  

    <div id="account" class="row">        
        <div class="col-lg-6">
            <table class="table table-responsive">				
				<tr> 
					<th style="width: 10em"><label><a class="text-danger"><strong>* </strong></a>Nombre:</label></th>
					<td>  <span>  
                         <input type="text" class="form-control" v-model="form.name">    
                            <small v-if="errors.name" class="error is-danger  text-danger">
                                Adiciona un nombre 
                            </small>  
                    </td>                 
				</tr>
                <tr>
					<th><label >NIT</label></th>
					<td>
                        <span>
                           <input type="text" class="form-control" v-model="form.identification">    
                        </span>
                    </td>
				</tr>
				<tr>
					<th><label >Dirección</label></th>
					<td>
                        <smll>
                            <input type="text" class="form-control" v-model="form.address">    
                        </small>
                    </td>
				</tr>
                <tr>
					<th><label >Ciudad</label></th>
					<td>
                        <span>
                            <input type="text" class="form-control" v-model="form.city">    
                        </span>
                    </td>
				</tr>
                <tr>
					<th><label >Teléfono</label></th>
					<td>
                        <span>
                            <input type="text" class="form-control" v-model="form.phone">    
                        </span>
                    </td>
				</tr>
                <tr>
					<th><span >Sitio Web</span></th>
					<td>
                        <span>
                            <input type="text" class="form-control" v-model="form.website">    
                        </span>
                    </td>
				</tr>
                
			</table>
            </div>
            <div class="col-lg-6">

             <table class="table table-responsive">				
			
                <tr>
					<th><span >Email</span></th>
					<td>
                        <span>
                            <input type="text" class="form-control" v-model="form.email">    
                        </span>
                          <small v-if="errors.email" class="error is-danger  text-danger">
                                Este correo ya existe en nuestra base de datos, intenta uno diferente.
                            </small>  
                    </td>
				</tr>
                <tr>
					<th><span >Régimen</span></th>
					<td>
                        <span>
                            <select name="cars" class="form-control" v-model="form.regime_id">
                                 <option v-for="option in companyregime" v-bind:value="option.id">
                                    @{{ option.value }}
                                </option>
                            </select>
                        </span>
                    </td>
				</tr>
                 <tr>
					<th><span >Moneda</span></th>
					<td>
                        <span>
                            COP
                        </span>
                    </td>
				</tr>
                 <tr>
					<th><span >Precisión decimal</span></th>
					<td>
                        <span>
                            <select name="decprec" class="form-control" v-model="form.decimal_precision">
                                 <option v-for="option in dec_precision" v-bind:value="option.value">
                                    @{{ option.text }}
                                </option>
                            </select>
                        </span>
                    </td>
				</tr>
                 <tr>
					<th><span >Separador de decimales para exportar</span></th>
					<td>
                        <span>
                           <select name="decsep" class="form-control" v-model="form.decimal_separator">
                                 <option v-for="option in dec_separator" v-bind:value="option.value">
                                    @{{ option.text }}
                                </option>
                            </select>
                        </span>
                    </td>
				</tr>
                 <tr>
					<th><span >Logo de tu empresa</span></th>
					<td>
                        <span>
                           <div class="fileinput fileinput-new" data-provides="fileinput">
                            <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 200px; height: 150px;"></div>
                            <div>                                
                                <input type="file" @change="uploadLogo">
                                <a @click="deleteImage()" class="fa fa-remove fileinput-exists" data-dismiss="fileinput"></a>                                
                            </div>
                            
                            </div>
                        </span>
                    </td>
				</tr>
			</table>
            </div>
           
        </div> 

<!--
<pre><code>@{{$data | json}}</code></pre>

-->

