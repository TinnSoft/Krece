
{!!Html::style('http://webapplayers.com/inspinia_admin-v2.7/css/plugins/summernote/summernote-bs3.css')!!}
{!!Html::style('https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css')!!}
{!!Html::script('https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.min.js')!!}

<div class="modal inmodal fade" id="SendEmailModal" tabindex="-1" role="dialog"  aria-hidden="true">


     <div class="modal-dialog " >
           <div class="modal-content animated fadeIn" >
             
              
                <div class="modal-body">
                <p class="text-center"><span class="text-navy">@{{email.header}}<span> </p>
                    <div class="mail-box">
                        <div class="mail-body">

                            <form class="form-horizontal" method="get">
                                <div class="form-group"><label class="col-sm-2 control-label">Para:</label>
                                    <div class="col-sm-10"><input type="text" class="form-control input-sm" v-model="email.to"></div>
                                </div>
                                <div class="form-group"><label class="col-sm-2 control-label">Asunto:</label>
                                    <div class="col-sm-10"><input type="text" class="form-control input-sm" v-model="email.subject"></div>
                                </div>
                                </form>
                        </div>
                     </div>

                     <div class="mail-text h-200">

                            <div class="summernote" >
                                 <p v-model="email.body"></p>
                            </div>
                            <div class="clearfix"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancelar</button>                    
                    <button type="button" @click="" class="btn btn-primary">Enviar</button>                                            
                </div>
            </div>
    </div>
    
 </div>
<pre>@{{email}}</pre>
 <script>

    $(document).ready(function(){
        $('.summernote').summernote();
    });


 </script>