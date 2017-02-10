
<!--evita que se muestren los caracteres ocultos mientras se cargan los datos-->
<style>
[v-cloak] {
  display: none;
}
</style>



    <div class="row">
            <div class="col-lg-7">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><strong>Numeración</strong><small><br>  Indica el número con el cual debe crearse cada uno de tus documentos. 
                            Éste se incrementa de manera automática.</small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>             
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <table class="table table-responsive">		
                                 <tr v-for="item in resolution_number"> 
                                     <td style="width: 20em"><small>@{{item.text}}</small><a class="text-danger"><strong> *</strong></a></td>
                                     <td>  
                                        <span>                              
                                            <input type="text" class="form-control" v-model="resolution_number.number"> 
                                        </span>                           
                                    </td>    
                                 </tr>
                                  
                            </table>

                            <div class="panel-footer">
                                <div class="clearfix">                 
                                    <button class="btn btn-primary pull-right" @click="update" :disabled="isProcessing"><i class="fa fa-save"></i>&nbsp;Guardar</button>                   
                                    
                                </div>
                            </div>
                         </div>
                        </div>
                    </div>
                </div>
             </div>
         </div>


