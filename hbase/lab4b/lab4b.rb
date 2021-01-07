#Your Jruby script code goes here

require 'time'
import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'
import 'javax.xml.stream.XMLStreamConstants'

def jbytes( *args )
    args.map { |arg| arg.to_s.to_java_bytes }
end

factory = javax.xml.stream.XMLInputFactory.newInstance
reader = factory.createXMLStreamReader(java.lang.System.in)


food = nil
buffer = nil
count = 0

table = HTable.new( @hbase.configuration, 'foods' )
table.setAutoFlush( false )

while reader.has_next
    type = reader.next
    if type == XMLStreamConstants::START_ELEMENT
        case reader.local_name
        when 'Food_Display_Row' then food = {}
        when /Added_Sugars|Alcohol|Calories|Display_Name|Drkgreen_Vegetables|Drybeans_Peas|Food_Code|Factor|Increment|Grains|Fruits|Orange_Vegetables|Meats|Oils|Milk|Other_Vegetables|Multiplier|Portion_Amount|Portion_Default|Other_Vegetables|Portion_Display_Name|Starchy_vegetables|Vegetables|Saturated_Fats|Solid_Fats|Soy|Whole_Grains/ then buffer = []
    end
    elsif type == XMLStreamConstants::CHARACTERS
        buffer << reader.text unless buffer.nil?
    elsif type == XMLStreamConstants::END_ELEMENT
        case reader.local_name
        when /Added_Sugars|Alcohol|Calories|Display_Name|Drkgreen_Vegetables|Drybeans_Peas|Food_Code|Factor|Increment|Grains|Fruits|Orange_Vegetables|Meats|Oils|Milk|Other_Vegetables|Multiplier|Portion_Amount|Portion_Default|Other_Vegetables|Portion_Display_Name|Starchy_vegetables|Vegetables|Saturated_Fats|Solid_Fats|Soy|Whole_Grains/ 
            food[reader.local_name] = buffer.join
        when 'Food_Display_Row'
            key = food['Display_Name'].to_java_bytes


            p = Put.new( key )
            p.add( *jbytes("fact", "Added_Sugars", food["Added_Sugars"]))
            p.add( *jbytes("fact", "Alcohol", food["Alcohol"]))
            p.add( *jbytes("fact", "Calories", food["Calories"]))
            p.add( *jbytes("fact", "Display_Name", food["Display_Name"]))
            p.add( *jbytes("fact", "Drkgreen_Vegetables", food["Drkgreen_Vegetables"]))
            p.add( *jbytes("fact", "Drybeans_Peas", food["Drybeans_Peas"]))
            p.add( *jbytes("fact", "Food_Code ", food["Food_Code "]))
            p.add( *jbytes("fact", "Factor", food["Factor"]))
            p.add( *jbytes("fact", "Increment", food["Increment"]))
            p.add( *jbytes("fact", "Grains", food["Grains "]))
            p.add( *jbytes("fact", "Fruits", food["Fruits"]))
            p.add( *jbytes("fact", "Orange_Vegetables", food["Orange_Vegetables"]))
            p.add( *jbytes("fact", "Meats", food["Meats"]))
            p.add( *jbytes("fact", "Oils", food["Oils"]))
            p.add( *jbytes("fact", "Milk", food["Milk"]))
            p.add( *jbytes("fact", "Other_Vegetables", food["Other_Vegetables"]))
            p.add( *jbytes("fact", "Multiplier", food["Multiplier"]))
            p.add( *jbytes("fact", "Portion_Amount", food["Portion_Amount"]))
            p.add( *jbytes("fact", "Portion_Default", food["Portion_Default"]))
            p.add( *jbytes("fact", "Other_Vegetables", food["Other_Vegetables"]))
            p.add( *jbytes("fact", "Portion_Display_Name", food["Portion_Display_Name"]))
            p.add( *jbytes("fact", "Starchy_vegetables", food["Starchy_vegetables"]))
            p.add( *jbytes("fact", "Vegetables", food["Vegetables"]))
            p.add( *jbytes("fact", "Saturated_Fats", food["Saturated_Fats"]))
            p.add( *jbytes("fact", "Solid_Fats", food["Solid_Fats"]))
            p.add( *jbytes("fact", "Soy", food["Soy"]))
            p.add( *jbytes("fact", "Whole_Grains", food["Whole_Grains"])) 
         
            table.put( p )
            count += 1
            table.flushCommits() if count % 10 == 0
            if count % 500 == 0
                puts "#{count} records inserted (#{food['title']})"
            end
        end
    end
end
table.flushCommits()
exit

#Do not remove the exit call below
exit
