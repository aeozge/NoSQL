#Your code goes here

import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'

def jbytes( *args )
    args.map { |arg| arg.to_s.to_java_bytes }
end

def put_many( table_name, row, column_values)
    # Set table name
    table = HTable.new( @hbase.configuration, table_name)

    p = Put.new(*jbytes(row))

    # Parse each column_value from the set {} of key, value pairs the user inputs.

    column_values.each do | key, value|
        (column_family, column_qualifier) = key.split(':')
        column_qualifier ||= ""
        p.add( *jbytes( column_family, column_qualifier, value) )
    end
table.put( p )
end

# Call your put_many function

put_many  'wiki', 'NoSQL', {
"text:" => "What is your favorite part of this class?",
"revision:author" => "Ozge Erol",
"revision:comment" => "My favorite part is learning the subjects that we will need to use in the future work enviroment." }

get 'wiki', 'NoSQL'

#Do not remove the exit call below
exit