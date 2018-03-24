<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>
<% java.util.Calendar cal = java.util.Calendar.getInstance(); %>
<Flights>
<AirCarrier>AA</AirCarrier>
<FlightNumber>700</FlightNumber>
<FlightSegment>
  <DepartingInfo>
    <City>DFW</City>
      <Date>30Mar</Date>
      <Scheduled>
      <% out.print(cal.getTime().toString()); %>
      </Scheduled>
      <Status>ON TIME</Status>
      <% cal.add(java.util.Calendar.MINUTE, 10);
         out.print("<Time>" + cal.getTime().toString() +
         "</Time>"); %>
      <Gate>C16</Gate>
      <OffGateTime>0644A</OffGateTime>
      <OffGroundTime>0632A</OffGroundTime>
    </DepartingInfo>
    <ArrivingInfo>
      <City>LGA</City>
      <Date>30Mar</Date>
      <Scheduled>
      <% cal.add(java.util.Calendar.HOUR_OF_DAY, 4);
         out.print(cal.getTime().toString());
         cal.add(java.util.Calendar.MINUTE, 2); %>
      </Scheduled>
      <Status>ON TIME</Status>
      <Time><%= cal.getTime().toString() %></Time>
      <Gate>D5</Gate>
      <Baggage>B</Baggage>
      <OnGroundTime>1043A</OnGroundTime>
    </ArrivingInfo>
  </FlightSegment>
</Flights>