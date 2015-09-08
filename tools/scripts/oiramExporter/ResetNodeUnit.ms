--�����ԭ���Ǵ���һ��box����,Ȼ��attachĿ�������,��boxȥ��,����Ŀ������ĵ�λ�ͺ�boxһ����
fn oiramResetNodeUnit obj =
(	
	--get the pros
	tempP = obj.pivot
	tempN = obj.name
	tempC = obj.wirecolor

	--bigin refesh
	b = convertToPoly(box())
	newName = uniquename (b.name as string)
	polyOp.attach b obj
	b.EditablePoly.SetSelection #Face #{1}
	b.selectElement()
	TargetElement = polyop.getFaceSelection b
	polyop.detachFaces b TargetElement asNode:true name:newName
	b.pivot = tempP
	b.name = tempN
	b.wirecolor = tempC
	select b
	NewObj = getnodebyname newName
	delete NewObj
)


fn oiramResetSelectionNodeUnit =
(
	if selection.count != 0 then
	(
		with redraw off
		undo on
		(
			sel = getcurrentselection()
			for s in sel do
			(
				if classof s == Editable_Poly then 
				(
					oiramResetNodeUnit s
				)
				else
				if classof s == Editable_Mesh then
				(
					convertToPoly s
					oiramResetNodeUnit s
					convertToMesh s
				)--end else
			)--end for
		) --end undo on
		max views redraw
	)
)