
var formatdate="dd/mm/yyyy";

Vue.component('datepicker-vue', {
template: '\
  <input class="form-control datepicker"\
        ref="input"\
        v-bind:value="value"\
        v-on:input="updateValue($event.target.value)"\
        data-date-format="dd/mm/yyyy"\
        placeholder="DD/MM/YYYY"\
        type="text"  />\
',
props: {
    value: {
      type: String,
      default: moment().format(formatdate)
    }
},
mounted: function() {
    let self = this;
    this.$nextTick(function() {
        $(this.$el).datepicker({
             format: formatdate,
                todayBtn: true,
                clearBtn: true,
                language: "es",
                daysOfWeekHighlighted: "0",
                calendarWeeks: true,
                todayHighlight: true,      
                autoclose: true
        })
        .on('changeDate', function(e) {
            var date = e.format(formatdate);
            self.updateValue(date);
        });
    });
},
methods: {
    updateValue: function (value) {
        this.$emit('input', value);
    },
}
});
