<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${warehouse.message(code: 'orders.label', default: 'Purchase orders').toLowerCase()}" />
        <title><warehouse:message code="default.list.label" args="[entityName]" /></title>
    </head>    
    <body>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <div class="box">

            <h2><warehouse:message code="default.list.label" args="[entityName]" /></h2>
         	<table>
            	<thead>
					<tr>   
						<th>${warehouse.message(code: 'default.actions.label')}</th>
                        <th>${warehouse.message(code: 'default.status.label')}</th>
                        <th>${warehouse.message(code: 'default.description.label')}</th>
						<th>${warehouse.message(code: 'default.origin.label')}</th>
						<th>${warehouse.message(code: 'order.orderedBetween.label', default: 'Ordered between')}</th>
						<th>${warehouse.message(code: 'default.lastUpdated.label')}</th>
					</tr>
				</thead>		            
				<tbody>
            		<tr class="prop odd">            
			            <g:form action="list" method="post">
			            	<td></td>
                            <td class="filter-list-item middle">
                                <g:select name="status"
                                          from="${org.pih.warehouse.order.OrderStatus.list()}" class="chzn-select-deselect"
                                          optionValue="${{format.metadata(obj:it)}}" value="${status}"
                                          noSelection="['':warehouse.message(code:'default.all.label')]" />
                            </td>
			            	<td>
                                <g:textField class="text" name="description" value="${params.description}"/>

			            	</td>
				           	<td class="filter-list-item middle">
					           	<g:select name="origin" class="chzn-select-deselect"
					           							from="${suppliers}"
					           							optionKey="id" optionValue="name" value="${origin}" 
					           							noSelection="['':warehouse.message(code:'default.all.label')]" />
							</td>
				           	<td class="filter-list-item middle" nowrap="nowrap">
					           	<g:jqueryDatePicker id="statusStartDate" name="statusStartDate"
																	value="${statusStartDate}" format="MM/dd/yyyy"/>

								<g:jqueryDatePicker id="statusEndDate" name="statusEndDate"
																	value="${statusEndDate}" format="MM/dd/yyyy"/>
																	
																	
								<a href="javascript:void(0);" class="clear-dates"><warehouse:message code="default.clear.label"/></a>
							</td>
				           	<td class="filter-list-item" style="height: 100%; vertical-align: middle">
								<button name="filter" class="button icon edit">
									<warehouse:message code="default.button.filter.label"/>
								</button>
							</td>
			            </g:form>
					</tr>					
									
				
				
		            <g:unless test="${orders}">
		            	<tr class="prop">
		            		<td colspan="6">
                                <div class="empty fade center">
    			           			<warehouse:message code="orders.none.message"/>
                                </div>
				           	</td>
						</tr>     
		           	</g:unless>
            
					<g:each var="orderInstance" in="${orders}" status="i">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">            
							<td class="middle">
								<div class="action-menu">
									<g:render template="/order/actions" model="[orderInstance:orderInstance,hideDelete:true]"/>
								</div>	
							</td>
                            <td class="middle">
                                <format:metadata obj="${orderInstance?.status}"/>
                            </td>
							<td class="middle">
								<g:link action="show" id="${orderInstance.id}">
									${fieldValue(bean: orderInstance, field: "description")}
								</g:link>				
							</td>
							<td class="middle">
								${fieldValue(bean: orderInstance, field: "origin.name")}
							</td>
							<td class="middle">
								<format:date obj="${orderInstance?.dateOrdered}"/>
							</td>
							<td class="middle">
								<format:date obj="${orderInstance?.lastUpdated}"/>
							</td>
                        </tr>
					</g:each>                    		
				</tbody>
			</table>
        </div>
		<script type="text/javascript">
			$(function() { 		
				$(".clear-dates").click(function() {
					$('#statusStartDate-datepicker').val('');					
					$('#statusEndDate-datepicker').val('');
					$('#statusStartDate').val('');					
					$('#statusEndDate').val('');
				});			
			});
        </script>
    </body>
</html>