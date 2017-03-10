
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}



    <div class="jqGrid_wrapper"> 
        <div class="ibox-content">     
            <table id="bankaccount-grid"></table>
            <div id="pager_list_2"></div>     
        </div>        
    <div>

    <script>
        
        $(document).ready(function () {       
            var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes bncos creados!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('bank_account.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear banco</a> </div></div> '");
          

            $("#bankaccount-grid").jqGrid({
                url: "/getBankAccountlist",               
                datatype: "json",
                mtype: 'GET',
                colModel: [                   
                    { label: 'Nombre de la cuenta', name: 'bank_account_name', index: 'name', width: 75, sorttype: "text" },
                    { label: 'Número de cuenta', name: 'bank_account_number', width: 90 },
                    { label: 'Descripción', name: 'bank_account.description', width: 90 },
                    { label: 'Saldo', name: 'initial_balance', width: 90,formatter: 'currency',
                    formatoptions: { decimalSeparator: '.', decimalPlaces: 2, thousandsSeparator: ',', prefix: '$' }},  
                    {name:'public_id',  keys: true,"width":100, label:'Acciones', index:'public_id',  "align":"right" , 
                     sortable: false, formatter: displayButtons }      
                ],
                 autoresizeOnLoad: true,
                viewrecords: true, 
                autowidth: true,
                shrinkToFit: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },             
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:"Mis bancos",
                loadonce:true,               
                loadComplete: function () {
                    var count = $("#bankaccount-grid").getGridParam();
                    var ts = $("#bankaccount-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#bankaccount-grid").hide();
                        emptyMsgDiv.insertAfter($("#bankaccount-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#bankaccount-grid").show();
                        emptyMsgDiv.hide();
                    };
                   // resizewidth();
                },         
                pager:"#pager_list_2"
            });

  
         
             jQuery('#bankaccount-grid').jqGrid('navGrid','#pager_list_2',
                {
                    "edit":false,
                    "add":false,
                    "del":false,
                    "search":true,
                    "refresh":false,
                    "view":false,
                    "excel":false,
                    "pdf":false,
                    "csv":false,
                    "columns":false
                },
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150},
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150}
                );
                                
              setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='cursor: pointer ; color:green' onClick=appBank.goEdit(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'Ver' class='fa fa-eye fa-2x' style='cursor: pointer; color:blue'  onClick=appBank.goShow(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x'  style='cursor: pointer; color:red' onclick=appBank.remove(\""+cellvalue+"\")/></div><span > </span>";
                    
                
                if (rowObject.isDefault==1)
                {
                    Delete = "<div title= 'Eliminar' class='fa fa-remove fa-2x'  style='color:#F3D8D5'/></div><span > </span>";
                    //edit = "<div  title= 'Editar'  class='fa fa-pencil fa-2x' style='color:#ABEBC6'/></div><span > </span>";
                    
                }

                return edit + Details + Delete;
            }   


             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#bankaccount-grid').setGridWidth(width); 
            } 

        });


    </script>

