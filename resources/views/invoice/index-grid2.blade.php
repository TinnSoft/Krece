
    {!!Html::style('/themes/krece/css/plugins/dataTables/datatables.min.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/dataTables/datatables.min.js')!!} 

<style>

</style>
    <table id="invoice" class="display  responsive" cellspacing="0" width="100%" >
        <thead>
            <tr>
                <th>Id</th>
                <th>Contacto</th>
                <th>Fecha creación</th>
                <th>Fecha vencimiento</th>
                <th>total</th>
                <th>total pagado</th>
                <th>pendiente por pagar</th>
                <th>estado</th>
                <th>id contacto</th>
                <th>public id</th>
            </tr>
        </thead>
    </table>


    <script>
    moment.locale('es');

    $(document).ready(function() {
        $('#invoice').DataTable( {
            "paging"    : true,
            "processing": true,
            "serverSide": true,
            "ajax": "getInvoiceList",
            "language": {
                "url": "/themes/krece/js/plugins/dataTables/spanish.lang"
            },
            "columns":[
                {data:'resolution_id'},
                {data:'contact_name'},
                {data:'created_at'},
                {data:'due_date'},
                {data:'total'},
                {data:'total_payed'},
                {data:'pending_to_pay'},
                {data:'status_id'},
                {data:'contact_id'},
                {data:'public_id'}               
            ]
        } );
    } );

    </script>

