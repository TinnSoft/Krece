Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#creditnote',
  components: {
    "Multiselect": VueMultiselect.Multiselect
  },
  data: function () {
    return {
      isProcessing: false,
      name: '',
      form: {},
      errors: {},
      customer_list: [],
      currency: [],
      listPrice: [],
      product_list: [],
      taxes: [],
      redirect: '/credit-note/',
    }
  },
  //similar on load event

  created: function () {
    this.fetchData();
    Vue.set(this.$data, 'form', _form);
  },
  beforeMount() {
    this.getCurrentDate();
  },

  methods: {
    onInputContact: function (val) {
      if (val) {
        this.form.customer_id = val.id;
      }
      else {
        this.form.customer_id = '';
      }
    },

    onInputTax: function (val) {
      if (val.taxes) {
        val.tax_amount = val.taxes.value;

        val.tax_id = val.taxes.id;
      }
      else {
        val.tax_amount = "";
        val.tax_id = '';
      }
    },
    onInputlistprice: function (val) {
      if (val)
      { this.form.list_price_id = val.id; }
      else
      { this.form.list_price_id = ''; }
    },
    onInputCurrency: function (val) {
      if (val)
      { this.form.currency_code = val.code; }
      else
      { this.form.currency_code = ''; }
    },
    onInputProduct: function (val) {
      if (val.product) {
        val.description = val.product.description;
        val.unit_price = val.product.sale_price;
        val.product_id = val.product.id;
        val.reference = val.product.reference;
        val.name = val.product.name;
      }
      else {
        val.product_id = "";
        val.description = '';
        val.unit_price = 0;
        val.product_id = '';
        val.reference = '';
        val.name = '';
      }
    },
    currencyLabel({
      code,
      symbol
    }) {
      if (code) {
        if (!symbol) {
          symbol = "$";
        }
        return `${code} — [${symbol}]`
      }
    },

    getCurrentDate: function () {
      var d = new Date();
      var n = d.toLocaleDateString();
      if (this.form.date == "") {
        this.form.date = n;
      }
    },
    addLine: function (e) {
      this.form.detail.push({
        product_id: null,
        name: '',
        description: '',
        unit_price: 0,
        discount: 0,
        quantity: 1,
        tax_amount: 0
      });
    },
    removeItem: function (detail) {
      var index = this.form.detail.indexOf(detail)
      this.form.detail.splice(index, 1);
    },
    fetchData: function () {
      //carga de los datos del header
      var vm = this
      axios.get('/getCreditNoteBaseInfo')
        .then(function (response) {
          Vue.set(vm.$data, 'customer_list', response.data.contacts);
          Vue.set(vm.$data, 'currency', response.data.currency);
          Vue.set(vm.$data, 'listPrice', response.data.listprice);
          Vue.set(vm.$data, 'product_list', response.data.productlist);
          Vue.set(vm.$data, 'taxes', response.data.taxes);

          if (!vm.$data.form.list_price) {
            Vue.set(vm.$data.form, 'list_price', response.data.list_price);
            Vue.set(vm.$data.form, 'list_price_id', response.data.list_price.id);
          }

          if (vm.$data.form.public_id == "") {
            vm.$data.form.public_id = response.data.public_id;
          }

          if (vm.$data.form.resolution_id == "") {
            vm.$data.form.resolution_id = response.data.resolution_id.number;
          }

          if (!vm.$data.form.currency) {
            Vue.set(vm.$data.form, 'currency', response.data.default_Currency);
            Vue.set(vm.$data.form, 'currency_code', response.data.default_Currency.code_id);
          }

        })
        .catch(function (error) {
          Vue.set(vm.$data, 'errors', error);
        })
    },
    create: function () {
      var vm = this;
      vm.isProcessing = true;
      var ldbtn = Ladda.create(document.querySelector('.ladda-button'));
    	ldbtn.start();
      axios.post(vm.redirect, vm.form)
        .then(function (response) {
          if (response.data.created) {
            window.location = vm.redirect + response.data.id;
          } else {
            vm.isProcessing = false;
          }
          ldbtn.stop();
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
          ldbtn.stop();
        });
    },

    update: function () {
      var vm = this;
      vm.isProcessing = true;
      var ldbtn = Ladda.create(document.querySelector('.ladda-button'));
    	ldbtn.start();
      axios.put(vm.redirect + vm.form.id, vm.form)
        .then(function (response) {
          if (response.data.updated) {
            vm.isProcessing = false;
            ldbtn.stop();
            window.location = vm.redirect + response.data.id;
          } else {
            vm.isProcessing = false;
            ldbtn.stop();
          }
          
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
          ldbtn.stop();
        })
    }
  },
  //valores calculados
  computed: {
    subTotal: function () {
      var _subtotal = this.form.detail.reduce(function (carry, detail) {
        return carry + (parseFloat(detail.quantity) * parseFloat(detail.unit_price));
      }, 0);
      _subtotal = isNaN(_subtotal) ? 0 : _subtotal;
      this.form.sub_total = _subtotal;
      return _subtotal;
    },
    DiscountsTotal: function () {
      var discountsTot = this.form.detail.reduce(function (carry, detail) {
        return carry + (((parseFloat(detail.quantity) * parseFloat(detail.unit_price)) * parseFloat(detail.discount))) / 100;
      }, 0);
      this.form.total_discounts = isNaN(discountsTot) ? 0 : discountsTot;
      return isNaN(discountsTot) ? 0 : discountsTot
    },

    TaxesTotal: function () {
      var TaxTot = this.form.detail.reduce(function (carry, detail) {
        return carry + ((((parseFloat(detail.quantity) * parseFloat(detail.unit_price))
          - ((parseFloat(detail.quantity) * parseFloat(detail.unit_price)) * parseFloat(detail.discount)) / 100) *
          parseFloat(detail.tax_amount))) / 100;
      }, 0);

      this.form.total_taxes = isNaN(TaxTot) ? 0 : TaxTot;

      return isNaN(TaxTot) ? 0 : TaxTot
    },

    grandTotal: function () {
      var totalval = (isNaN(this.subTotal) ? 0 : parseFloat(this.subTotal)) -
        (isNaN(this.DiscountsTotal) ? 0 : parseFloat(this.DiscountsTotal)) + (isNaN(this.TaxesTotal) ? 0 : parseFloat(this.TaxesTotal));


      this.form.total = totalval;
      return isNaN(totalval) ? 0 : totalval
    }
  }
})


/*Formato de moneda */
Vue.filter('formatCurrency', function (value) {
  return accounting.formatMoney(value);
});
