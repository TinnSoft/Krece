 
Vue.component('select2-vue', {
   twoWay: true,
  props: ['options', 'value'],
  template: '<select><slot></slot></select>',
  mounted: function () {
    var vm = this
    $(this.$el)
      .val(this.value).select2(  
        { 
          data: this.options,
          allowClear: true
        })
      .on('change', function () {
        vm.$emit('input', this.value)
      })
  },
  watch: {
    value: function (value) {
    var select = $(this.$el).select2();
    select.val(value).trigger("change");
    },
    options: function (options) {
          // update options
          $(this.$el).select2({ data: options })
        }
  },
  destroyed: function () {
    $(this.$el).off().select2('destroy')
  }
});

