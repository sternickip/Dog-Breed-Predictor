app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$uploadFile(input_image = "640px-YellowLabradorLooking_new.jpg") # <-- This should be the path to the file, relative to the app's tests/shinytest directory
# Input 'Table_rows_current' was set, but doesn't have an input binding.
# Input 'Table_rows_all' was set, but doesn't have an input binding.
# Input 'Table_state' was set, but doesn't have an input binding.
app$setInputs(top_n = 4)
# Input 'Table_rows_current' was set, but doesn't have an input binding.
# Input 'Table_rows_all' was set, but doesn't have an input binding.
# Input 'Table_state' was set, but doesn't have an input binding.
app$setInputs(top_n = 3)
# Input 'Table_rows_current' was set, but doesn't have an input binding.
# Input 'Table_rows_all' was set, but doesn't have an input binding.
# Input 'Table_state' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(top_n = 4)
# Input 'Table_rows_current' was set, but doesn't have an input binding.
# Input 'Table_rows_all' was set, but doesn't have an input binding.
# Input 'Table_state' was set, but doesn't have an input binding.
app$setInputs(top_n = 5)
# Input 'Table_rows_current' was set, but doesn't have an input binding.
# Input 'Table_rows_all' was set, but doesn't have an input binding.
# Input 'Table_state' was set, but doesn't have an input binding.
app$snapshot()
app$uploadFile(input_image = "139491036_204634801334150_557233583129386025_n.jpg") # <-- This should be the path to the file, relative to the app's tests/shinytest directory
# Input 'Table_rows_current' was set, but doesn't have an input binding.
# Input 'Table_rows_all' was set, but doesn't have an input binding.
# Input 'Table_state' was set, but doesn't have an input binding.
app$snapshot()
