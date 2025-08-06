local checked = {} 
for i, v in workspace.Models:GetChildren() do 
	if not table.find(checked, v.Name) then 
		table.insert(checked, v.Name) 
		print(v.Name) 
	else 
		warn(`!!DUPLICATE!! {v.Name}`) 
	end 
end