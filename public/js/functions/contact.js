Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#contact',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data:  {   
    isProcessing: false,
    name: '',
    form: {},
    errors: {},
    paymentterms:[],   
    listPrice:[],   
    sellers:[]
  },
    //similar on load event

  created: function () {  
      this.fetchData();
      Vue.set(this.$data, 'form', _form); 
    },
  methods: {       
      onInputlistprice:function(val)
      {
        if(val)
        {this.form.list_price_id=val.id; }
        else
        {this.form.list_price_id=''; }      
      },
      onInputSeller:function(val)
      {
        if(val)
        {this.form.seller_id=val.id; }
        else
        {this.form.seller_id=''; }      
      },
      onInputPaymentT:function(val)
      {
        if(val)
        {this.form.payment_terms_id=val.id; }
        else
        {this.form.payment_terms_id=''; }    
      },
      addLine: function(e) {      
        this.form.contact_others.push({ 
                  name:'',
                  last_name:'',
                  phone:'',
                  email: '',
                  phone_mobile:'',
                  notify:0});           
      },
      removeItem: function(detail) {      
        var index = this.form.contact_others.indexOf(detail)
        this.form.contact_others.splice(index,1);
      },
      fetchData: function()
      {    
        //carga de los datos del header
        var vm = this
                  axios.get('/getContactBaseInfo')
                      .then(function(response) {  
                                          
                          Vue.set(vm.$data, 'paymentterms', response.data.paymentterms);
                          Vue.set(vm.$data, 'listPrice', response.data.listprice);
                          Vue.set(vm.$data, 'sellers', response.data.sellers);
                      })
                      .catch(function(error) {
                          console.log(error)
                      })                  
      },
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post('/contact', vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = '/contact/' + response.data.id;
              } else {
                vm.isProcessing = false;
              }
            })
            .catch(function (error) {        
              vm.isProcessing = false;
              Vue.set(vm.$data, 'errors', error.response.data);
            });
      },

      update: function() {
      var vm = this;    
        vm.isProcessing = true;
        axios.put('/contact/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {
             
              window.location = '/contact/' + response.data.id;
            } else {             
              vm.isProcessing = false;
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
          })
      }   
    }
 
})
