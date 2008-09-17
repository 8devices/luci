var cbi_d = [];

function cbi_d_add(field, dep, next) {
	var obj = document.getElementById(field);
	if (obj) {
		var entry
		for (var i=0; i<cbi_d.length; i++) {
			if (cbi_d[i].id == field) {
				entry = cbi_d[i];
				break;
			}
		}
		if (!entry) {
			entry = {
				"node": obj,
				"id": field,
				"parent": obj.parentNode.id,
				"next": next,
				"deps": []
			};
			cbi_d.unshift(entry);
		}	
		entry.deps.push(dep)
	}
}

function cbi_d_checkvalue(target, ref) {
	var t = document.getElementById(target);
	var value
	
	if (!t) {
		return true
	} else if (!t.value) {
		value = "";
	} else {
		value = t.value;
		
		if (t.type == "checkbox") {
			value = t.checked ? value : "";
		}
	}
	
	return (value == ref)
}

function cbi_d_check(deps) {
	for (var i=0; i<deps.length; i++) {
		var istat = true
		for (var j in deps[i]) {
			istat = (istat && cbi_d_checkvalue(j, deps[i][j]))
		}
		if (istat) {
			return true
		}
	}		
}

function cbi_d_update() {
	var state = false;
	for (var i=0; i<cbi_d.length; i++) {
		var entry = cbi_d[i];
		var next  = document.getElementById(entry.next)
		var node  = document.getElementById(entry.id)
		var parent = document.getElementById(entry.parent)

		if (node && node.parentNode && !cbi_d_check(entry.deps)) {
			node.parentNode.removeChild(node);
			state = (state || !node.parentNode)
		} else if ((!node || !node.parentNode) && cbi_d_check(entry.deps)) {
			if (!next) {
				parent.appendChild(entry.node);
			} else {
				next.parentNode.insertBefore(entry.node, next);
			}		
			state = (state || (node && node.parentNode))
		}
	}
	if (state) {
		cbi_d_update();
	}
}

function cbi_bind(obj, type, callback, mode) {
	if (typeof mode == "undefined") {
		mode = false;
	}
	if (!obj.addEventListener) {
		ieCallback = function(){
			var e = window.event;
			if (!e.target && e.srcElement) {
				e.target = e.srcElement;
			};
			e.target['_eCB' + type + callback] = callback;
			e.target['_eCB' + type + callback](e);
			e.target['_eCB' + type + callback] = null;
		};
		obj.attachEvent('on' + type, ieCallback);
	} else {
		obj.addEventListener(type, callback, mode);
	}
	return obj;
}

function cbi_combobox(id, values, def, man) {
	var obj = document.getElementById(id)
	var sel = document.createElement("select");
	if (obj.nextSibling) {
		obj.parentNode.insertBefore(sel, obj.nextSibling);	
	} else {
		obj.parentNode.appendChild(sel);
	}

	if (!values[obj.value]) {
		if (obj.value == "") {
			var optdef = document.createElement("option");
			optdef.value = "";
			optdef.appendChild(document.createTextNode(def));
			sel.appendChild(optdef);
		} else {
			var opt = document.createElement("option");
			opt.value = obj.value;
			opt.selected = "selected";
			opt.appendChild(document.createTextNode(obj.value));
			sel.appendChild(opt);
		}
	}

	for (var i in values) {
		var opt = document.createElement("option");
		opt.value = i;

		if (obj.value == i) {
			opt.selected = "selected";
		}

		opt.appendChild(document.createTextNode(values[i]));
		sel.appendChild(opt);
	}

	var optman = document.createElement("option");
	optman.value = "";
	optman.appendChild(document.createTextNode(man));
	sel.appendChild(optman);

	obj.style.display = "none";

	cbi_bind(sel, "change", function() {
		if (sel.selectedIndex == sel.options.length - 1) {
			obj.style.display = "inline";
			sel.parentNode.removeChild(sel);
			obj.focus();
		} else {
			obj.value = sel.options[sel.selectedIndex].value;
		}
	})
}

function cbi_combobox_init(id, values, def, man) {
	var obj = document.getElementById(id);
	cbi_bind(obj, "blur", function() {
		cbi_combobox(id, values, def, man)
	});
	cbi_combobox(id, values, def, man);
}