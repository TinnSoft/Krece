<div class="modal inmodal fade" id="categoryModal" tabindex="-1" role="dialog"  aria-hidden="true">
     <div class="modal-dialog modal-sm">
           <div class="modal-content animated fadeIn">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title">@{{header_modal}}</h4>                                            
                 </div>
                <div class="modal-body">
                    <div class="form-group"><label><a class="text-danger"><strong>* </strong></a>Nombre:</label> <input type="text" 
                        v-model="category.name" placeholder="Categoria" class="form-control">
                    </div>
                    <div class="form-group"><label>Descripción:</label> <input type="text" 
                        v-model="category.description" placeholder="Descripción" class="form-control">
                    </div>
                    <div class="form-group"><label>Cuenta NIIF:</label> <input type="text" 
                        v-model="category.niif_account" placeholder="# de cuenta" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancelar</button>
                    
                    <template v-if="category.name === ''">
                        <button type="button" class="btn btn-primary disabled">Guardar</button>
                    </template>
                    <template v-else>
                        <button type="button" @click="Modal_click_save()" class="btn btn-primary">Guardar</button>
                    </template>                            
                </div>
            </div>
    </div>
 </div>