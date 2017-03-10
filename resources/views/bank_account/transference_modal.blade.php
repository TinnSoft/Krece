<div class="modal inmodal fade" id="transferenceModal" tabindex="-1" role="dialog"  aria-hidden="true">
     <div class="modal-dialog ">
           <div class="modal-content animated fadeIn">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title text-navy">Transferencia entre cuentas</h4>                                            
                 </div>
                <div class="modal-body">
                    <table class="table table-responsive">				
                    <tr> 
                        <th style="width: 10em"><small><a class="text-danger"><strong>* </strong></a>Cuenta origen</small></th>
                        <td>  <span>  
                            <multiselect 
                                v-model="bank_account" 
                                :options="bank" 
                                :multiple="false" 
                                group-values="bank" 
                                group-label="description" 
                                placeholder="Seleccione..." 
                                track-by="bank_account_name" 
                                label="bank_account_name"
                                :show-labels="false"
                                :allow-empty="false"
                                 @input="accountFrom">                                
                            </multiselect>                      
                        </td>                 
                    </tr>
                    <tr>
                        <th><small ><label><a class="text-danger"><strong>* </strong></a>Cuenta destino:</label></small></th>
                        <td>                       
                           <multiselect 
                                v-model="bank_account_to" 
                                :options="bank" 
                                :multiple="false" 
                                group-values="bank" 
                                group-label="description" 
                                placeholder="Seleccione..." 
                                track-by="bank_account_name" 
                                label="bank_account_name"
                                :show-labels="false"
                                :allow-empty="false"
                                 @input="accountTo">                                
                            </multiselect>                            
                        </td>
                    </tr>
                    <tr>
                        <th><small ><label><a class="text-danger"><strong>* </strong></a>Monto:</label></small></th>
                        <td>                       
                            <small>
                                <input type="number" class="form-control input-sm" v-model="transfer.amount"></input>
                            </small>                    
                        </td>
                    </tr>
                    <tr>
                        <th><small ><label>Fecha:</label></small></th>
                        <td>                       
                             <datepicker-vue class="form-control" 
                                v-model="transfer.date" 
                                value='@{{transfer.date }}'>
                             </datepicker-vue>           
                        </td>
                    </tr>
                    <tr>
                        <th><small ><label>Observaciones:</label></small></th>
                        <td>                       
                            <small>
                               <textarea class="form-control input-sm" v-model="transfer.observations"></textarea>
                            </small>                    
                        </td>
                    </tr>
                    
                </table>    
                <small>Los campos marcados con <a class="text-danger"><strong> *</strong></a> son obligatorios</small>             
            </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancelar</button>  
                    <button class="btn btn-primary pull-right" :disabled="isProcesing" @click="create">
                    <i class="fa fa-save"></i>&nbsp;Guardar</button>                          
                </div>
            </div>
    </div>
 </div>