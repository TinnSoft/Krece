
{!!Html::style('https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css')!!}
{!!Html::script('https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.min.js')!!}

{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

<div class="modal inmodal fade" id="SendEmailModal" tabindex="-1" role="dialog"  aria-hidden="true">

     <div class="modal-dialog " >
           <div class="modal-content animated fadeIn" >             
              
                <div class="modal-body">
                <input type="hidden" name="mPublic_id" id='mPublic_id' ref='mPublic_id' v-model="email.public_id" >
                <input type="hidden" name="mModelFrom" id='mModelFrom' ref='mModelFrom' v-model="email.model_from" >

                <p class="text-center"><span class="text-navy">@{{email.header}}<span> </p>
                    <div class="mail-box">
                        <div class="mail-body">

                            <form class="form-horizontal" method="get">
                                <div class="form-group"><label class="col-sm-2 control-label">Para:</label>
                                    <div class="col-sm-10">
                                        <input 
                                        type="text" 
                                        class="form-control input-sm" 
                                        v-model="email.to" 
                                        id='emailTo' 
                                        ref='emailTo'>
                                    </div>
                                </div>
                                <div class="form-group"><label class="col-sm-2 control-label">Asunto:</label>
                                    <div class="col-sm-10">
                                        <input 
                                        type="text" 
                                        class="form-control input-sm" 
                                        v-model="email.subject"
                                        id='emailSubject' 
                                        ref='emailSubject'>
                                    </div>
                                </div>
                                </form>
                        </div>
                     </div>

                     <div class="mail-text h-200">                           
                            <div id="summernote" ></div>
                            <div class="clearfix"></div>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">Cancelar</button>                    
                    <button 
                        type="button" 
                        @click="appEmailToCustomer.sendEmailToCustomer()" 
                        data-style="zoom-in"
                        class="btn btn-primary ladda-button">Enviar
                    </button>                                            
                </div>
            </div>
    </div>
    
 </div>

<script>
var emailRE = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/


 var appEmailToCustomer = new Vue({
  el: '#_SendEmailToCustomer',
  data(){
      return {
         
        email: {
                subject: '',
                body: '',
                to:'',
                additional_emails:[],
                model_from:'',
                public_id:''
            },
            errors:{}
      }

  },
  computed: {
    validation: function () {

      return {    
        'email.to': emailRE.test(this.email.to)
      }
    },
    isValid: function () {
      var validation = this.validation
      return Object.keys(validation).every(function (key) {
        return validation[key]
      })
    }
  },
  methods: { 
    sendEmailToCustomer:function(){
            var self=this;
            self.email.to=emailTo.value;
            self.email.body=$('#summernote').summernote('code');
            self.email.subject=emailSubject.value;
            self.email.public_id=mPublic_id.value;
            self.email.model_from=mModelFrom.value;

            if (self.email.to=='')
            {
                swal("Porfavor revisar!", "Debe ingresar por lo menos un correo al cual va dirigido el email!!.", "warning");
            }
            else if (self.email.subject=='')
            {
                swal("Porfavor revisar!", "Debe especificar un asunto antes de enviar el correo.", "warning");
            }
            else
            {
                 if (self.isValid) {
                    self.SendEmail();  
                 }
                 else
                 {
                     swal("Correo invalido !", "Asegurese de ingresar una dirección de email válida.", "warning");
                 }              
            }
        },
        SendEmail:function() {
        var vm = this;
         	var ldbtn = Ladda.create(document.querySelector('.ladda-button'));
    		ldbtn.start();

            axios.post('/sendEmailToContact/', vm.email)
            .then(function (response) {
            if (response.data.created) {
                ldbtn.stop();
                swal("Envío finalizado", "Se ha enviado el correo al cliente seleccionado", "success");
                $('#SendEmailModal').modal('toggle'); 
            } else {
                ldbtn.stop();
                swal("Algo falló", "No ha sido posible completar la operación", "error");
            }
            })
            .catch(function (error) {
                ldbtn.stop();
                swal("Algo falló", "No ha sido posible completar la operación", "error");
                Vue.set(vm.$data, 'errors', error.response.data);
            });
        }
    }
})
</script>