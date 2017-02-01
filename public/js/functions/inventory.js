Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#inventory',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data: function() {   
    return{
    toUseListPrice:false,
    isProcessing: false,
    name: '',
    form: {},
    errors: {},
    measure_unit: [],
    listPrice:[],   
    taxes:[]
  }},
  created: function () {  
      this.fetchData();
      Vue.set(this.$data, 'form', _form); 
    },
  
  methods: {  
      toggleLListPrice: function () 
      {
        return this.toUseListPrice = this.toUseListPrice == true ? false : true
      },     
      onInputlistprice:function(val)
      {
        if(val)
        {this.form.list_price_id=val.id; }
        else
        {this.form.list_price_id=''; }      
      },
      onInputTax:function(val)
      {
        if(val)
        {this.form.tax_id=val.id; }
        else
        {this.form.tax_id=''; }      
      },
      onInputUnitMeasure:function(val)
      {
        if(val)
        {this.form.inv_type_id=val.id; }
        else
        {this.form.inv_type_id=''; }    
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
                  axios.get('/getInventoryBaseInfo')
                      .then(function(response) {  
                          Vue.set(vm.$data, 'taxes', response.data.taxes);
                          Vue.set(vm.$data, 'listPrice', response.data.listprice);
                          Vue.set(vm.$data, 'measure_unit', response.data.measure_unit);
                      })
                      .catch(function(error) {
                          console.log(error)
                      })                  
      },
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post('/inventory', vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = '/inventory/' + response.data.id;
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
        axios.put('/inventory/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {           
              window.location = '/inventory/' + response.data.id;
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
